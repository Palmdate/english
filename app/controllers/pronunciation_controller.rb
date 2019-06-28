# coding: utf-8
class PronunciationController < ApplicationController
  before_action :check_user
  
  def index
    @list_vowels = ["ʌ", "ɑ:", "æ", "e", "ə", "ɜ:", "ɪ", "i:", "ɒ", "ɔ:", "ʊ", "u:", "aɪ", "aʊ", "eɪ", "oʊ", "ɔɪ", "eə", "ɪə", "ʊə"]
    @list_consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "ŋ", "p", "r", "s", "ʃ", "t", "tʃ", "θ", "ð", "v", "w", "z", "ʒ", "dʒ"]
  end

  def only_word
    @ipa_letter = params[:ipa]
  end

  def list_word
  end
  def ipa_word
    word = params[:word]
    word_ipa = PronunciationHelper.to_ipa(word)
    render json: { status: 'success', message: word_ipa }
    @test = PronunciationHelper.to_ipa("eight")
  end
end
