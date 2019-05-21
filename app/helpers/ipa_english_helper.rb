module IpaEnglishHelper
  require "sqlite3"
  require "humanize"
  def to_ipa(words)
    words = to_exactly_type(words)
    db = SQLite3::Database.new 'ipagem.db'

    new_word = words.map do |w|
      temp = db.execute("SELECT phonetic FROM phonetics WHERE word == '#{w.upcase}'")
      temp.join(' ').to_s
      
    end
    p new_word*" "
      # temp = db.execute("SELECT phonetic FROM phonetics WHERE word == 'HELLO'")

  end

  
  def is_number(x)
    x.to_f.to_s == x.to_s || x.to_i.to_s == x.to_s
  end

  def to_exactly_type(words)
    words = words.split.map do |w|
      if is_number(w)
        w = w.to_f.humanize
        check_pharse(w)
      else
        w
      end
    end
    return words.to_sentence.split()
  end

  def check_pharse(text)
    if text.split.count > 1
      text = text.split(/\W+/).join(' ')
    end
    return text
  end
  
  
end
