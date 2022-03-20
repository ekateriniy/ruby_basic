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
      puts "\nВведите 1, чтобы создать поезд\n" \
           "Введите 2, чтобы создать маршрут\n" \
           "Введите 3, чтобы создать станцию\n" \
           "Введите 4, чтобы создать вагон\n" \
           "Введите 5, чтобы управлять станциями в маршруте\n" \
           "Введите 6, чтобы управлять маршрутом поезда и его вагонами\n" \
           "Введите 7, чтобы управлять вагонами\n" \
           "Введите 8, чтобы просмотреть список станций и поездов на них\n\n" \
           "Введите 0, чтобы закончить."

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
    puts available_stations
    start_station = station_object_reciever('начальной')
    finish_station = station_object_reciever('конечной')

    @routes << Route.new(start_station, finish_station)
    puts "Создан маршрут #{routes[-1].name.join(' - ')}"
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def create_train
    puts 'Введите тип поезда. Доступные типы: cargo, passenger'
    type = gets.chomp.to_sym

    puts 'Введите номер поезда.' \
    'Допустимый формат: три буквы или цифры в любом порядке, ' \
    'необязательный дефис и еще 2 буквы или цифры после дефиса.'
    number = gets.chomp

    train = case type
            when :cargo
              CargoTrain.new(number, type)
            when :passenger
              PassengerTrain.new(number, type)
            else
              Train.new(number, type)
            end

    @trains << train
    puts "Создан поезд типа #{train.type} с номером #{train.number}"
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def create_wagon
    puts 'Введите тип вагона. Доступные типы: cargo, passenger'
    type = gets.chomp.to_sym
    puts 'Введите номер вагона. Допустимый формат: семь цифр, без букв.'
    number = gets.chomp

    wagon = case type
            when :cargo
              puts 'Введите грузовой объем вагона'
              capacity = gets.to_i
              CargoWagon.new(number, type, capacity)
            when :passenger
              puts 'Введите количество мест в вагоне'
              seats = gets.to_i
              PassengerWagon.new(number, type, seats)
            end

    @wagons << wagon
    puts "Создан вагон типа #{wagon.type} с номером #{wagon.number}."
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def train_menu
    puts "Введите 1, чтобы назначить маршрут поезду\n" \
         "Введите 2, чтобы добавить или отцепить вагоны у поезда\n" \
         "Введите 3, чтобы переместить поезд по маршруту\n" \
         "Введите 4, чтобы посмотреть информацию о вагонах поезда\n\n" \
         "Введите 0, чтобы вернуться в главное меню"
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
      nil
    end
  end

  def assign_route_to_train
    if trains.nil?
      puts 'Поезда не найдены. Создайте поезд, чтобы присвоить ему маршрут'
      nil
    else
      puts available_trains
      train = train_object_reciever

      puts available_routes
      choisen_route = route_object_reciever

      train.get_route(choisen_route)
    end
  end

  def wagon_manegment
    puts 'Поезда:'
    trains.each_with_index do |train, i|
      puts "Индекс #{i}: номер #{train.number}, тип #{train.type}"
      puts 'Вагоны, прицепленные к поезду:'
      train.wagon_numbers.each_with_index { |number, i| puts "Индекс: #{i}, номер: #{number}" }
    end

    puts available_wagons

    puts "Введите 1, чтобы добавить вагон\n" \
    "Введите 2, чтобы отцепить вагон. " \
    "Вагон и поезд должны быть одного типа\n\n" \
    "Введите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    return if action.zero?

    train = train_object_reciever
    wagon = wagon_object_reciever

    case action
    when 1
      train.add_wagon(wagon)
    when 2
      train.remove_wagon(wagon)
    end

    puts "Вагоны поезда #{train.number}: #{train.wagon_numbers.join(', ')}"
  end

  def move_train
    puts "Введите 1, чтобы переместить поезд вперед\n" \
         "Введите 2, чтобы переместить поезд назад\n\n" \
         "Введите 0, чтобы вернуться в главное меню"
    direction = gets.to_i
    return if direction.zero?

    puts available_trains
    train = train_object_reciever

    case direction
    when 1
      train.move_forward
    when 2
      train.move_backward
    end
  end

  def train_info
    puts available_trains
    train = train_object_reciever

    train.each_wagon do |wagon|
      puts "Номер вагона: #{wagon.number}, тип: #{wagon.type}"
      case wagon.type
      when :cargo
        puts "Доступный грузовой объем: #{wagon.available_space}, занятый объем: #{wagon.booked_space}"
      when :passenger
        puts "Количество занятых мест: #{wagon.booked_space}, количество свободных мест: #{wagon.available_space}"
      end
    end
  end

  def route_menu
    puts "Введите 1, чтобы добавить станцию к маршруту\n" \
    "Введите 2, чтобы удалить станцию из маршрута\n\n" \
    "Введите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    return if action.zero?

    puts available_routes
    choisen_route = route_object_reciever

    puts available_stations
    choisen_station = station_object_reciever

    case action
    when 1
      choisen_route.add_station(choisen_station)
    when 2
      choisen_route.delete_station(choisen_station)
    end
  end

  def wagon_menu
    puts "Введите 1, чтобы занять место или объем в вагоне\n\n" \
    "Введите 0, чтобы вернуться в главное меню"
    action = gets.to_i
    return if action.zero?

    puts available_wagons
    wagon = wagon_object_reciever

    case wagon.type
    when :cargo
      puts "Введите нужный объем. Доступный объем: #{wagon.available_space}"
      cargo_volume = gets.to_i
      wagon.book_space(cargo_volume)
      puts "Осталось: #{wagon.available_space} свободного места"
    when :passenger
      wagon.book_seat
      puts "Осталось #{wagon.available_space} свободных мест"
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def station_info
    stations.each do |station|
      puts "Станция: #{station.name}"
      station.each_train do |train|
        puts "Номер поезда: #{train.number}, тип: #{train.type}, количество вагонов: #{train.wagons.size}"
      end
    end
  end

  private

  def available_trains(certain_station = nil)
    puts 'Имеющиеся поезда'
    if certain_station
      certain_station.trains.map.with_index { |train, i| "Индекс #{i}: номер #{train.number}, тип #{train.type}" }.join("\n")
    else
      trains.map.with_index { |train, i| "Индекс #{i}: номер #{train.number}, тип #{train.type}" }.join("\n")
    end
  end

  def available_wagons
    puts 'Имеющиеся вагоны:'
    wagons.map.with_index { |wagon, i| "Индекс #{i}: номер #{wagon.number}, тип #{wagon.type}" }.join("\n")
  end

  def available_routes
    puts 'Имеющиеся маршруты'
    routes.map.with_index { |route, i| "#{i}: #{route.name.join(' - ')}" }.join("\n")
  end

  def available_stations
    puts 'Имеющиеся станции'
    stations.map.with_index { |station, i| "#{i}: #{station.name}" }.join("\n")
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

  def route_object_reciever
    puts 'Введите номер(индекс) маршрута'
    route_index = gets.to_i
    routes[route_index]
  end

  def station_object_reciever(order = '')
    puts "Введите номер #{order} станции"
    station_index = gets.to_i
    stations[station_index]
  end
end
