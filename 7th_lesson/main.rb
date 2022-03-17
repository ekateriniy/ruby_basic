require_relative './modules/producer.rb'
require_relative './modules/instance_counter.rb'
require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'railroad.rb'

def seed(rr)
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

  w1 = CargoWagon.new(1238739, :cargo, 1000)
  w2 = CargoWagon.new(2946204, :cargo, 1500)
  w3 = PassengerWagon.new(8792274, :passenger, 200)
  w4 = PassengerWagon.new(8826403, :passenger, 100)

  t1.add_wagon(w1)
  t1.add_wagon(w2)
  t2.add_wagon(w3)
  t2.add_wagon(w4)

  r1 = Route.new(s1, s2)
  r1.add_station(s3)

  rr.trains.push(t1, t2, t3, t4)
  rr.stations.push(s1, s2, s3)
  rr.wagons.push(w1, w2, w3, w4)
  rr.routes << r1
end


rr = RailRoad.new
seed(rr)

# Задание для отсутствия интерфейса
rr.stations.each do |station|
  puts "station: #{station.name}"
  station.each_train do |train| 
    puts "train number: #{train.number}, train type: #{train.type}, number of wagons: #{train.wagons.size}"
    train.each_wagon do |wagon|
      puts "wagon number: #{wagon.number}, wagon type: #{wagon.type}"
      if wagon.type == :cargo
        puts "available space: #{wagon.available_space}, occupied space: #{wagon.occupied_space}"
      elsif wagon.type == :passenger
        puts "booked seats: #{wagon.booked_seats}, available seats: #{wagon.available_seats}"
      end
    end
  end
end

#rr.menu