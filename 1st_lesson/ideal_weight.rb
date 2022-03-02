#Идеальный вес

puts 'Введите имя'
name = gets.chomp.capitalize
puts 'Введите рост'
height = gets.to_i

ideal_weight = (height - 110) * 1.15
if ideal_weight < 0
  puts "#{name}, ваш вес уже оптимальный"
else
  puts "#{name}, ваш идеальный вес: #{ideal_weight}"
end