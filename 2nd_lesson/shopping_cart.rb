# #6. Сумма покупок. 

basket = {}
total_cart = 0
puts "для остановки введите \'стоп\'" 
loop do
  puts 'название товара'
  item = gets.chomp
  break if item == 'стоп'
  puts 'цена'
  item_price = gets.to_f
  puts 'количество товара'
  item_amount = gets.to_f
  basket[item] = {price: item_price, amount: item_amount}
end

basket.each do |item, item_params|
  total_item = item_params[:price] * item_params[:amount] 
  puts "#{item}: #{item_params[:price]}, #{item_params[:amount]}\nВсего за товар: #{total_item}"
  total_cart += total_item
end

puts "Сумма всех покупок: #{total_cart}"