class IpaEnglishController < ApplicationController
  include IpaEnglishHelper
 
 
  def index
    @ipa = convert("hello is smart")
  end
end
