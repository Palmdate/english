module PronunciationHelper
  require "sqlite3"
  require "humanize"
  
  def to_ipa(words)
    words = to_exactly_type(words)
    db = SQLite3::Database.new 'ipagem.db'

    new_word = words.map do |w|
      w = w.split(/\W+/).join(' ')
      
      temp = db.execute("SELECT phonetic FROM phonetics WHERE word == '#{w.upcase}'")
      temp.join(' ').to_s
      
    end
    p new_word*" "

  end

  
  def is_number(x)
    Float(x) != nil rescue false
  end

  def to_exactly_type(words)

    words = words.split.map do |w|
      # Remove . and , at end string
      w = w.sub(/\.+$/, '').sub(/\,+$/, '')
      if is_number(w)
        w = w.to_f.humanize
        check_pharse(w)
      else
        w
      end
    end
    return words.join(' ').split(' ')
  end

  # Remove - when convert humanize of number
  def check_pharse(text)
    if text.split.count > 1
      text = text.gsub("-", " ")
    end
    return text
  end
  
  # Analize result

  def array_ins(result)
    new_ins = result.split(Regexp.union(['<', '/ins>'])).select do |elem|
      elem.include? "ins"
    end
    new_ins.map{|x| x.gsub("ins>", "")}
  end

  def array_del(result)
    new_ins = result.split(Regexp.union(['<', '/del>'])).select do |elem|
      elem.include? "del"
    end
    new_ins.map{|x| x.gsub("del>", "")}
  end

  def parse_array(result)
    new_result = result.split(Regexp.union(['<del>'])).map{|elem| elem.split('</ins>').first}
  end

  def get_ipa
    array = ""
    ReadAloudReport.where.not(result: nil).pluck(:user_id, :result).each do |user_id, result|
      array_ins(result).each do |word|
        words = to_ipa(word)
        array += words
      end
    end

    # p array
    # array.uniq.each do |elem|
    #   puts "#{elem}\t#{array.count(elem)}"
    # end
    
    array.split('').uniq.each do |elem|

      puts "#{elem}\t#{array.count(elem)}"

    end
  end
  # Save ipa for each user
  
end
