class Train
  include Producer
  include InstanceCounter

  NUMBER_FORMAT = /^\w{3}-*\w{2}$/i

  @@all = {}

  attr_reader :speed, :type, :number, :wagons

  def self.all
    @@all
  end

  def self.find(number)
    @@all[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate_number!
    validate_type!
    @@all[number] = self
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
    wagon.change_belongins(self)
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
    if @current_station_index.zero?
      [@route_list[0], @route_list[1]]
    else
      [@route_list[@current_station_index - 1], @route_list[@current_station_index],
       @route_list[@current_station_index + 1]].compact
    end
  end

  def wagon_numbers
    wagons.map(&:number)
  end

  def valid?
    validate_number!
    validate_type!
    true
  rescue StandardError
    false
  end

  # Метод, который принимает блок и проходит по всем вагонам поезда (вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.
  def each_wagon(&block)
    wagons.each { |wagon| block.call(wagon) }
  end

  protected

  def validate_number!
    raise 'Number has invalid format.' if number.to_s !~ NUMBER_FORMAT
  end

  def validate_type!
    raise 'Type must be cargo or passenger' if type != :cargo && type != :passenger
  end

  private

  def train_moving?
    @speed != 0
  end

  def same_type?(wagon)
    wagon.type == type
  end

  def starting_station?
    @current_station_index.zero?
  end

  def finish_station?
    @current_station_index == @route_list.size - 1
  end
end
