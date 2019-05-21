module AdminHelper
  def list_7_days(user_id)
    list = ReadAloudReport.where("date(updated_at) between :start and :end", {start: 7.days.ago.to_date, end: Date.today}).where(:user_id => user_id).order(:updated_at)
    length_list = list.count
    array = []
    if list != []
      days = list.first.updated_at.to_date
      
      (0..6).each do |x|
        
        array = array + [["#{days + x.day}"] + list.select{|m| m.updated_at.to_date == days + x.day}.map{|k| k.percent}]
      end
    end
    # data = [['Year', 'Sales', 'Expenses', 'Profit'],
    #         ['2014', 100, 40, 20],
    #         ['2015', 11, 46, 25],
    #         ['2016', 60, 11, 30],
    #         ['2017', 10, 54, 35,10,56,90,80]]
    data = [['DATES']] + array

    return @data = (1..10).map do |i|
      {
        name: data.first[i],
        data: data[1..-1].map { |x| [ x[0], x[i] ] }
      }
    end
    
  end
end
