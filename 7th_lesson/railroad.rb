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
      puts "\nВведите 1, чтобы создать поезд\nВведите 2, чтобы создать маршрут\nВведите 3, чтобы создать станцию\nВведите 4, чтобы создать вагон\nВведите 5, чтобы управлять станциями в маршруте\nВведите 6, чтобы управлять маршрутом поезда и его вагонами\nВведите 7, чтобы управлять вагонами\nВведите 8, чтобы просмотреть список станций и поездов на них\n\nВведите 0, чтобы закончить."
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
        wagon_menu
      when 8
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
    puts 'Введите тип поезда. Доступные типы: cargo, passenger'
    train_type = gets.chomp.to_sym
    puts 'Введите номер поезда. Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис и еще 2 буквы или цифры после дефиса.'
    train_number = gets.chomp    
    
    train = case train_type
    when :cargo
      CargoTrain.new(train_number, train_type)
    when :passenger
      PassengerTrain.new(train_number, train_type)
    else
      Train.new(train_number, train_type)
    end

    @trains << train
    puts "Создан поезд типа #{train.type} с номером #{train.number}"

  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end
  
# При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
  def create_wagon
    puts 'Введите тип вагона. Доступные типы: cargo, passenger'
    wagon_type = gets.chomp.to_sym
    puts 'Введите номер вагона. Допустимый формат: семь цифр, без букв.'
    wagon_number = gets.chomp

    wagon = case wagon_type
    when :cargo
      puts 'Введите грузовой объем вагона'
      wagon_capacity = gets.to_i
      CargoWagon.new(wagon_number, wagon_type, wagon_capacity)
    when :passenger
      puts 'Введите количество мест в вагоне'
      wagon_seats = gets.to_i
      PassengerWagon.new(wagon_number, wagon_type, wagon_seats)
    else
      Wagon.new(wagon_number, wagon_type)
    end

    @wagons << wagon
    puts "Создан вагон типа #{wagon.type} с номером #{wagon.number}."

  rescue RuntimeError => e
      puts "#{e.message}"
      retry
  end

  def train_menu
    puts "Введите 1, чтобы назначить маршрут поезду\nВведите 2, чтобы добавить или отцепить вагоны у поезда\nВведите 3, чтобы переместить поезд по маршруту\nВведите 4, чтобы посмотреть информацию о вагонах поезда\n\nВведите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    case action
    when 1
      assign_route_to_train
    when 2
      wagon_manegment
    when 3
      move_train
    when 4
      train_info
    when 0
      return
    end
  end

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

# Выводить список вагонов у поезда (в указанном выше формате), используя созданные методы
  def train_info
    puts 'Поезда, информация о вагонах которых доступна:'
    trains_number.each_with_index { |train, i| puts "#{i}: #{train}"}
    train = train_object_reciever
    train.each_wagon do |wagon|
      puts "Номер вагона: #{wagon.number}, тип: #{wagon.type}"
      if wagon.type == :cargo
        puts "Доступный грузовой объем: #{wagon.available_space}, занятый объем: #{wagon.occupied_space}"
      elsif wagon.type == :passenger
        puts "Количество занятых мест: #{wagon.booked_seats}, количество свободных мест: #{wagon.available_seats}"
      end
    end
  end

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

#Занимать место и объем в вагоне
  def wagon_menu
    puts "Введите 1, чтобы занять место или объем в вагоне\n\nВведите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    return if action == 0

    puts 'Имеющиеся вагоны:' 
    wagons.each_with_index { |wagon, i| puts "Индекс #{i}: номер #{wagon.number}, тип #{wagon.type}"}
    wagon = wagon_object_reciever

    case wagon.type
    when :cargo
      puts "Введите нужный объем, доступный объем: #{wagon.available_space}"
      cargo_volume = gets.to_i
      wagon.occupy_space(cargo_volume)
      puts "Осталось: #{wagon.available_space} свободного места"
    when :passenger
      wagon.book_seat
      puts "Осталось #{wagon.available_seats} свободных мест"
    end

    rescue RuntimeError => e
    puts "#{e.message}"
    retry

  end

# Вывод поездов на станции с помощью созданных методов
  def station_info
    stations.each do |station|
      puts "Станция: #{station.name}"
      station.each_train do |train| 
        puts "Номер поезда: #{train.number}, тип: #{train.type}, количество вагонов: #{train.wagons.size}"
      end
    end
  end

  private

  def trains_number(certain_station = nil)
    if certain_station
      list_of_numbers = certain_station.trains.map { |train| train.number }
    else
      list_of_numbers = trains.map { |train| train.number }
    end
    list_of_numbers
  end

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