class RailRoad
  attr_reader :trains, :stations, :routes, :wagons

  def initialize
    @routes = []
    @stations = []
    @trains = []
    @wagons = []
  end

  def menu
    loop do
      puts "\nВведите 1, чтобы создать поезд\nВведите 2, чтобы создать маршрут\nВведите 3, чтобы создать станцию\nВведите 4, чтобы создать вагон\nВведите 5, чтобы управлять станциями в маршруте\nВведите 6, чтобы управлять маршрутом поезда и его вагонами\nВведите 7, чтобы просмотреть список станций и поездов на них\n\nВведите 0, чтобы закончить."
      action = gets.to_i
      case action
      when 1
        create_train
      when 2
        create_route
      when 3
        create_station
      when 4
        create_wagon
      when 5
        route_menu
      when 6
        train_menu
      when 7
        station_info
      when 0
        break
      end
    end
  end

  def create_route
    stations.each_with_index { |station| puts "#{i}: #{station.name}" }
    puts 'Введите номер начальной станции из предложенных выше'
    start_station = station_object_reciever
    puts 'Введите номер конечной станции'
    finish_station = station_object_reciever
    @routes << Route.new(start_station, finish_station)
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def create_train
    puts "Введите \'г\' для создания грузового поезда и \'п\' для создания пассажирского"
    type = gets.chomp
    puts 'Введите номер поезда'
    train_number = gets.to_i
    @trains << case type
      when 'г'
        CargoTrain.new(train_number, :cargo)
      when 'п'
        PassengerTrain.new(train_number, :passenger)
    end
  end
  
  def create_wagon
    puts "Введите \'г\' для создания грузового и \'п\' для создания пассажирского"
    wagon_type = gets.chomp
    puts 'Введите номер вагона'
    wagon_number = gets.to_i
    @wagons << case wagon_type
      when 'г'
        CargoWagon.new(wagon_number, :cargo)
      when 'п'
        PassengerWagon.new(wagon_number, :passenger)
    end
  end

#Меню действий с поездом
  def train_menu
    puts "Введите 1, чтобы назначить маршрут поезду\nВведите 2, чтобы добавить или отцепить вагоны у поезда\nВведите 3, чтобы переместить поезд по маршруту\n\nВведите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    case action
    when 1
      assign_route_to_train
    when 2
      wagon_manegment
    when 3
      move_train
    when 0
      return
    end
  end

# Присвоить поезду маршрут
  def assign_route_to_train
    unless trains.nil?
      puts 'Имеющиеся поезда:'
      trains_number.each_with_index { |train, i| puts "#{i}: #{train}"}
      train = train_object_reciever
      routes.each_with_index { |route, i| puts "#{i}: #{route.stations[0].name} - #{route.stations[-1].name}"}
      puts 'Введите выбранный номер маршрута, который хотите присвоить поезду'
      choisen_route = gets.to_i

      route = routes[choisen_route]
      train.get_route(route)
    end
  end  

# Добавлять и отцеплять вагоны у поезда
  def wagon_manegment
    puts 'Поезда:' 
    trains.each_with_index do |train, i| 
      puts "Индекс #{i}: номер #{train.number}, тип #{train.type}"
      puts "#{train_wagons_info(train)}"
    end

    puts 'Вагоны:' 
    wagons.each_with_index { |wagon, i| puts "Индекс #{i}: номер #{wagon.number}, тип #{wagon.type}"}

    puts "Введите 1, чтобы добавить вагон\nВведите 2, чтобы отцепить вагон. Вагон и поезд должны быть одного типа\n\nВведите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    return if action == 0
    train = train_object_reciever
    wagon = wagon_object_reciever

    case action
    when 1
      train.add_wagon(wagon)
      train_wagons_info(train)
    when 2
      train.remove_wagon(wagon)
      train_wagons_info(train)
    end
  end

# Двигать поезд 
  def move_train
    puts "Введите 1, чтобы переместить поезд вперед\nВведите 2, чтобы переместить поезд назад\n\nВведите 0, чтобы вернуться в главное меню"
    direction = gets.to_i
    return if direction == 0
    puts 'Имеющиеся поезда:'
    trains_number.each_with_index { |train, i| puts "#{i}: #{train}"}
    train = train_object_reciever

    case direction
    when 1
      train.move_forward
    when 2
      train.move_backward
    end
  end

# Управлять станциями в маршруте (добавлять, удалять станции)
  def route_menu
    puts "Введите 1, чтобы добавить станцию к маршруту\nВведите 2, чтобы удалить станцию из маршрута\n\nВведите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    return if action == 0
    routes.each_with_index { |route, i| puts "#{i}: #{route.name.join(' - ')}"}
    puts 'Введите номер изменяемого маршрута из списка'
    choisen_route = gets.to_i
    puts 'Введите номер станции из списка'
    stations.each_with_index { |station, i| puts "#{i}: #{station.name}" }
    choisen_station = station_object_reciever
    
    case action
    when 1
      routes[choisen_route].add_station(choisen_station)
    when 2
      routes[choisen_route].delete_station(choisen_station)
    end
  end

# Просматривать список станций и поездов на них
  def station_info
    stations.each do |station|
      puts "Станция: #{station.name}"
      puts "Номера поездов на станции:#{trains_number(station).join(', ')}"
    end
  end

  private

#Вынесены в private, тк действия и методы используются по несколько раз, но вне класса они не нужны
#puts в методах оставлен, для отсутствия постоянного дублирования. Нужно, наверное, без него, но в контексте конкретно данной программы такой способ видится логичней
  def trains_number(certain_station = nil)
    if certain_station
      list_of_numbers = certain_station.trains.map { |train| train.number }
    else
      list_of_numbers = trains.map { |train| train.number }
    end
    list_of_numbers
  end

#У меня есть большие сомнения в том, можно ли выносить в один и тот же метод и вывод строки, и прием данных ввода от пользователя, и возврат объекта. И тем более использовать в публичных методах присваивание через эти методы. Я решила их объединить просто чтобы не разбивать каждый метод на 2-3 отдельных конкретно в этой программе 
  def wagon_object_reciever
    puts 'Введите номер(индекс) вагона'
    wagon_index = gets.to_i
    wagons[wagon_index]
  end

  def train_object_reciever
    puts 'Введите номер(индекс) поезда'
    train_index = gets.to_i
    trains[train_index]
  end 

  def station_object_reciever
    station_index = gets.chomp
    stations[station_index]
  end
end