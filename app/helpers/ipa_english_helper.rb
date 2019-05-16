module IpaEnglishHelper
  require "sqlite3"
  require "humanize"
  
  def to_ipa(words)
    words = to_exactly_type(words)
    db = SQLite3::Database.new 'ipagem.db'

    new_word = words.map do |w|
      temp = db.execute("SELECT phonetic FROM phonetics WHERE word == '#{w}'")
      temp.join(' ').to_s
      
    end
    p new_word*" "
      # temp = db.execute("SELECT phonetic FROM phonetics WHERE word == 'HELLO'")

  end

  
  def is_number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end

  def to_exactly_type(words)
    words = words.split.map do |w|
      if w.is_number?
        w = w.to_f.humanize
      else
        w
      end
    end
  
  end
  
end
