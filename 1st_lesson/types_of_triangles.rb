#Прямоугольный треугольник

puts 'введите значение гипотенузы'
hypotenuse = gets.to_f
puts 'введите значение первого катета'
a_leg = gets.to_f
puts 'введите значение второго катета'
b_leg = gets.to_f

if a_leg == b_leg && b_leg == hypotenuse
  puts 'треугольник равносторонний и равнобедренный'
elsif a_leg == b_leg
  puts 'треугольник равнобедренный' 
elsif a_leg ** 2 + b_leg ** 2 == hypotenuse ** 2
  puts 'треугольник прямоугольный'
else
  puts 'какой-то непонятный треугольник'
end
