module ReadAloudsHelper
  
  def get_chart_user()
    ReadAloudChart.where(user_id:current_user.id).order(:updated_at)
  end
  def list_days()
    data = get_chart_user()
    days = data.pluck(:updated_at).map{|x| Date.parse(x.to_s).to_s}.uniq
  end

  # def rate_by_day()
  def get_list_rate()
    data = get_chart_user()
    rates =  data.pluck(:rate)
    if rates.count < 30
      rates = rates + [0] * (30 - rates.count)
    else
      rates.last(30)
    end
  end

  def get_list_sentence()
    
    data = get_chart_user()
    
    sents =  data.pluck(:sentence).map{|x| "Sentence " + x.to_s}
    if sents.count < 30
      sents = sents + ["No data"] * (30 - sents.count)
    else
      sents.last(30)
    end
  end
  
end
# JSON.parse(list_days.replace(/&quot;/g,'"')),
