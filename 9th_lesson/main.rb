require_relative './modules/producer'
require_relative './modules/instance_counter'
require_relative './modules/validation'
require_relative './modules/accessors'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'railroad'

def seed(railroad)
  t1 = CargoTrain.new('afs-jj', :cargo)
  t2 = PassengerTrain.new('alf-33', :passenger)
  t3 = PassengerTrain.new('sfa-1e', :passenger)
  t4 = CargoTrain.new('dfk-33', :cargo)

  s1 = Station.new('spb')
  s2 = Station.new('hel')
  s3 = Station.new('sin')

  s1.arrival(t1)
  s1.arrival(t3)
  s3.arrival(t2)

  w1 = CargoWagon.new(1_238_739, :cargo, 1000)
  w2 = CargoWagon.new(2_946_204, :cargo, 1500)
  w3 = PassengerWagon.new(8_792_274, :passenger, 200)
  w4 = PassengerWagon.new(8_826_403, :passenger, 100)

  t1.add_wagon(w1)
  t1.add_wagon(w2)
  t2.add_wagon(w3)
  t2.add_wagon(w4)

  r1 = Route.new(s1, s2)
  r1.add_station(s3)

  railroad.trains.push(t1, t2, t3, t4)
  railroad.stations.push(s1, s2, s3)
  railroad.wagons.push(w1, w2, w3, w4)
  railroad.routes << r1
end

test_railroad = RailRoad.new
seed(test_railroad)

# Задание для отсутствия интерфейса
test_railroad.stations.each do |station|
  puts "station: #{station.name}"

  station.each_train do |train|
    puts "train number: #{train.number}, train type: #{train.type}, number of wagons: #{train.wagons.size}"

    train.each_wagon do |wagon|
      puts "wagon number: #{wagon.number}, wagon type: #{wagon.type}"

      case wagon.type
      when :cargo
        puts "available space: #{wagon.available_space}, booked space: #{wagon.booked_space}"
      when :passenger
        puts "booked seats: #{wagon.booked_space}, available seats: #{wagon.available_space}"
      end
    end
  end
end

test_railroad.menu
