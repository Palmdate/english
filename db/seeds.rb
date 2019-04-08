# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# (1..10).each do |n|
#   WriteFrDic.create
#   (
#     audio: '#{n}',
#     content: nil
#   )
# end
WriteFrDic.all.each do |k|
  k.destroy
end

(1..10).each do |n|
  
  WriteFrDic.create(audio: "#{n}.wav", content: "ha test.")

end
