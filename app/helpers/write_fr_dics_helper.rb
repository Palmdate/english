module WriteFrDicsHelper
  require 'fuzzystringmatch'

  def count_matching_rate(left, right)
    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    p jarow.getDistance(left, right)
  end
end
