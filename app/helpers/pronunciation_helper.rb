# coding: utf-8
module PronunciationHelper
  include Pagy::Frontend
  require "sqlite3"
  require "humanize"
  
  def self.to_ipa(words)
    words = to_exactly_type(words)
    db = SQLite3::Database.new 'ipagem.db'

    new_word = words.map do |w|
      w = w.split(/\W+/).join(' ')
      
      temp = db.execute("SELECT phonetic FROM phonetics WHERE word == '#{w.upcase}'")
      if temp == []
        UnknowIpa.new(:word => w).save
      end
      temp.join(' ').to_s
      
    end
    p new_word*" "

  end

  
  def self.is_number(x)
    Float(x) != nil rescue false
  end

  def self.to_exactly_type(words)

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
  def self.check_pharse(text)
    if text.split.count > 1
      text = text.gsub("-", " ")
    end
    return text
  end
  
  # Analize result

  def self.array_ins(result)
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

  def self.get_ipa(record)
    hash_ipa = Hash.new
    array = ""
    record.where.not(result: nil).pluck(:result).each do |result|
      
      array_ins(result).each do |word|
        words = to_ipa(word)
        array += words
      end
    end

    # Check all ipa: i: => i, u: => u
    # /ʌ+|a+|æ+|e+|ə+|ɝ+|ɪ+|i+|ɑ+|ɔ+|ʊ+|u+|aɪ+|aʊ+|eɪ+|oʊ+|ɔɪ+|eə+|ɪə+|ʊə+|b+|d+|f+|g+|h+|j+|k+|ɫ+|m+|n+|ŋ+|p+|r+|s+|ʃ+|t+|tʃ+|θ+|ð+|v+|w+|z+|ʒ+|dʒ+/
    
    # Get list include double vowels and consotants
    array_double = array.scan /aɪ+|aʊ+|eɪ+|oʊ+|ɔɪ+|eə+|ɪə+|ʊə+|tʃ+|dʒ+/
    array_double.uniq.each do |elem|
      hash_ipa[elem] = array_double.count(elem)
    end
    #  Get list include one vowels and consotants
    array_once = array.gsub(/aɪ|aʊ|eɪ|oʊ|ɔɪ|tʃ|dʒ|ɜr|ər|ɑr|ɔr|er|ɪr/, '')
    new_array = array_once.scan /ʌ+|ɑ+|æ+|e+|ə+|ɪ+|i+|ʊ+|u+|b+|d+|f+|g+|h+|j+|k+|ɫ+|m+|n+|ŋ+|p+|r+|s+|ʃ+|t+|tʃ+|θ+|ð+|v+|w+|z+|ʒ+/
    new_array.uniq.each do |elem|
      hash_ipa[elem] = new_array.count(elem)
    end
    # Get 3 max values with wrong pronunciation
    return max_3_values(hash_ipa)
  end
  
  # Save ipa for each user
  def self.max_3_values(hash)
    hash.select do |key, value|
      hash.values.max(3).include? value
    end
  end

  def self.save_record_ipa
    list_user = ReadAloudChart.where("date(updated_at) between :start and :end", {start: 14.days.ago.to_date, end: Date.today}).order(:updated_at).pluck(:user_id)
    list_result = ReadAloudChart.where("date(updated_at) between :start and :end", {start: 14.days.ago.to_date, end: Date.today}).order(:updated_at)
    list_user.each do |user_id|
      hash_ipa = get_ipa(list_result.where(user_id: user_id))
      result_user = IpaUser.find_by(user_id: user_id)
      if result_user.nil?
        IpaUser.new(:user_id => user_id, :alphabet_wrong => hash_ipa.keys, :alphabet_done => [], :alphabet_trainning => Hash.new).save!
      else
        result_user.update(:alphabet_wrong => hash_ipa.keys)
      end
    end
  end

end
