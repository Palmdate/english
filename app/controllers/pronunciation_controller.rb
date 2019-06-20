# coding: utf-8
class PronunciationController < ApplicationController
  def index
    @list_vowels = ["ʌ", "ɑ:", "æ", "e", "ə", "ɜ:", "ɪ", "i:", "ɒ", "ɔ:", "ʊ", "u:", "aɪ", "aʊ", "eɪ", "oʊ", "ɔɪ", "eə", "ɪə", "ʊə"]
    @list_consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "ŋ", "p", "r", "s", "ʃ", "t", "tʃ", "θ", "ð", "v", "w", "z", "ʒ", "dʒ"]
  end

  def only_word
    @ipa_letter = params[:ipa]
  end

  def list_word
  end
end
