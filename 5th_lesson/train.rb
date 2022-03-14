class Train
  include Producer
  include InstanceCounter
  @@all_type_trains = {}

  attr_reader :speed, :type, :number, :wagons

  class << self
    attr_writer :all

    def all
      @all ||= {}
    end

    def find(number)
      @@all_type_trains[number]
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    self.class.all[number] = self
    @@all_type_trains[number] = self
    register_instance
  end

  def speed_up(value)
    @speed += value
  end
  
  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if same_type?(wagon) && !train_moving?
      @wagons << wagon
      wagon.change_belongins(self)
    end
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) unless train_moving?
    wagon.change_belongins(nil)
  end

  def get_route(route)
    @route_list = route.stations
    @current_station_index = 0
  end

  def move_forward
    @current_station_index += 1 unless finish_station?
  end

  def move_backwards
    @current_station_index -= 1 unless starting_station?
  end
    
  def status
    if @current_station_index == 0
      [@route_list[0], @route_list[1]]
    else
      [@route_list[@current_station_index - 1], @route_list[@current_station_index], @route_list[@current_station_index + 1]].compact
    end
  end

#Метод для вытаскивания номеров вагонов у конкретного поезда
  def wagon_numbers
    wagons.map { |wagon| wagon.number }
  end

#Методы проверки состояния класса, доступ к которым не нужен в других классах
  private

  def train_moving?
    return true if @speed != 0
    false
  end

  def same_type?(wagon)
    wagon.type == type ? true : false
  end

  def starting_station?
    @current_station_index == 0 ? true : false   
  end

  def finish_station?
    @current_station_index == @route_list.size - 1 ? true : false    
  end
end
