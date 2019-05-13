module IpaEnglishHelper
  require "sqlite3"
  
  def convert(words)
    words = words.upcase.split
    db = SQLite3::Database.new 'ipagem.db'

    new_word = words.map do |w|
      temp = db.execute("SELECT phonetic FROM phonetics WHERE word == '#{w}'")
      temp.join(' ').to_s
      
    end
    p new_word*" "
      # temp = db.execute("SELECT phonetic FROM phonetics WHERE word == 'HELLO'")

  end
end
