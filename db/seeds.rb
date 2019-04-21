# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# (1..10).each do |n|
#   WriteFrDic.create
#   (
#     audio: '#{n}',
#     content: nil
#   )
# end
# Examples:
#
#   movies => Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

wfd = { "April19_1.mp3" => "Archaeologists discovered tools and artifacts in ancient tombs.",
        "April19_2.mp3" => "Blue whale is the largest mammal that ever lived.",
        "April19_3.mp3" => "Children conquer their first language without any efforts.",
        "April19_4.mp3" => "Essay and assignment are spread across the academic year.",
        "April19_5.mp3" => "Even simple techniques need to be practiced to become perfect.",
        "April19_6.mp3" => "Firm conclusions can be established through rigorous experiments.",
        "April19_7.mp3" => "Graphs are often useful for geographical research.",
        "April19_8.mp3" => "Horizontal line on the graph indicates there is no change.",
        "April19_9.mp3" => "International exchanges formulate the study of our program.",
        "April19_10.mp3" => "It is successfully acknowledged that there is a student graduation ceremony.",
        "April19_11.mp3" => "It takes a long time to walk to university.",
        "April19_12.mp3" => "Late applications are not accepted under any circumstances.",
        "April19_13.mp3" => "Make sure you have saved all the files before turning off the computer.",
        "April19_14.mp3" => "Measures must be taken to prevent the unemployment rate from rising.",
        "April19_15.mp3" => "Momentum is defined as a combination of mass and velocity.",
        "April19_16.mp3" => "Salt is extracted from seawater from the ground.",
        "April19_17.mp3" => "Slides and handouts can be downloaded after the lecture.",
        "April19_18.mp3" => "Social media is a criticism of critical decisions.",
        "April19_19.mp3" => "Sociology policies are the sources of government to solve social problems.",
        "April19_20.mp3" => "Sound waves are unable to travel through the vacuum.",
        "April19_21.mp3" => "Statistically speaking, the likelihood of the result is extremely low.",
        "April19_22.mp3" => "Students should leave their bags on the table by the door.",
        "April19_23.mp3" => "The area has a number of underwater habitats in species.",
        "April19_24.mp3" => "The coffee machine on the third floor is not working today.",
        "April19_25.mp3" => "The collapse of the housing market makes recessions.",
        "April19_26.mp3" => "The course tomorrow will require higher skill levels.",
        "April19_27.mp3" => "The north campus car park could be closed on Sunday.",
        "April19_28.mp3" => "The reception staff can give information about renting and printing.",
        "April19_29.mp3" => "The reception staff give advices about renting accommodation.",
        "April19_30.mp3" => "There is a widely believed perception that engineering is for boys.",
        "April19_31.mp3" => "You must set a security question when resetting your password.",
        "April19_32.mp3" => "Your ideas are discussed depending on your seminar or tutorial."
      }

WriteFrDic.all.each do |k|
  k.destroy
end


wfd.each do |name, content|
  
  WriteFrDic.create(audio: name, result: content)

end
