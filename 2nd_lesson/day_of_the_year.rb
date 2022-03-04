#5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, начиная отсчет с начала года.

def leap?(year)
  if year % 4 == 0
    if year % 100 == 0 && year % 400 != 0
      return false
    end
    true
  else
    false
  end
end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'введите число'
day = gets.to_i
puts 'введите номер месяца'
month = gets.to_i
puts 'введите год'
year = gets.to_i

day += 1 if leap?(year) && month > 2
day_of_the_year = day + months[0...(month - 1)].sum

puts "это #{day_of_the_year} день"
