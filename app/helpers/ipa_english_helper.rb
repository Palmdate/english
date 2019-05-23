module IpaEnglishHelper
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
    return words.to_sentence.split(' ')
  end

  # Remove - when convert humanize of number
  def check_pharse(text)
    if text.split.count > 1
      text = text.gsub("-", " ")
    end
    return text
  end
  
  
end
