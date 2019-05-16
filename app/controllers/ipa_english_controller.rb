class IpaEnglishController < ApplicationController
  include IpaEnglishHelper
 
 
  def index
    @ipa = to_ipa("hello is smart")
  end
end
