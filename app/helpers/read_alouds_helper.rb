module ReadAloudsHelper
 
  
  def get_chart_user()
    
    ReadAloudChart.where(user_id:current_user.id)
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
      rates = [0] * (30 - rates.count) + rates
    #else
     # rates.order(':updated_at ASC').last(30)
    end
  end

  def get_list_sentence()
    
    data = get_chart_user()
    
    sents =  data.pluck(:sentence).map{|x| "Sentence " + x.to_s}
    if sents.count < 30
      sents = ["No data"] * (30 - sents.count) + sents
    #else
     # sents.order(':updated_at ASC').last(30)
    end
  end
  
end
# JSON.parse(list_days.replace(/&quot;/g,'"')),
