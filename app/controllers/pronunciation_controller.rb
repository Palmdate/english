# coding: utf-8
class PronunciationController < ApplicationController
  include Pagy::Backend
  before_action :check_user
  
  def index
    # Check again ɑ ~ ɔ, fact: ɔ = o, ɑ = ɒ
    # ɜ, ɪə, ʊə
    # ɑ ~ ɔ ~ a
    @list_vowels = ["ʌ", "ɑ", "æ", "e", "ə", "ɜr", "ər", "ʊr", "ɪ", "i:", "ɑr", "ɔr", "ʊ", "u:", "aɪ", "aʊ", "eɪ", "oʊ", "ɔɪ", "er", "ɪr"]
    @list_consonants = ["b", "p", "f", "v", "t", "d", "l", "g", "h", "k", "m", "n", "ŋ", "s", "ʃ", "z", "ʒ", "tʃ", "θ", "ð", "r", "w", "j", "dʒ"]
    ipa_user = IpaUser.find_by(user_id: current_user.id)
    @alphabet_wrong = ipa_user.nil? ? [] : ipa_user.alphabet_wrong
    @alphabet_done = ipa_user.nil? ? [] : ipa_user.alphabet_done
    @alphabet_trainning = ipa_user.nil? ? [] : ipa_user.alphabet_trainning

  end

  def only_word
    @ipa_letter = params[:ipa]
    @ipa_words = Ipa.all.find_by(name: @ipa_letter).list_words

  end

  def ipa_word
    word = params[:word]
    word_ipa = PronunciationHelper.to_ipa(word)
    render json: { status: 'success', message: word_ipa }
    @test = PronunciationHelper.to_ipa("eight")
  end

  def store_alphabet_trainning
    ipa_letter = params[:ipa_letter]
    word = params[:word]
    ipa_user = IpaUser.find_by(user_id: current_user.id)
    if ipa_user.nil?
      ipa_user = IpaUser.new(:user_id => current_user.id, :alphabet_wrong => [], :alphabet_done => [], :alphabet_trainning => Hash.new).save!
    end
    
    list_word = Ipa.all.find_by(name: ipa_letter).list_words
    percent = ((list_word.index(word) + 1).to_f / list_word.size * 100).to_i
   
    if percent == 100
      new_done = ipa_user.alphabet_done + [ipa_letter]
      new_wrong = ipa_user.alphabet_wrong - [ipa_letter]
      new_trainning = ipa_user.alphabet_trainning.except(ipa_letter)
    else
      new_trainning = ipa_user.alphabet_trainning.merge!(ipa_letter => percent)
      new_done = ipa_user.alphabet_done - [ipa_letter]
      new_wrong = ipa_user.alphabet_wrong - [ipa_letter]
    end
    
    ipa_user.update(:alphabet_wrong => new_wrong, :alphabet_done => new_done, :alphabet_trainning => new_trainning)
  end
  
end
