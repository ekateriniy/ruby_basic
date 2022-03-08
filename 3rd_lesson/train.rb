class Train
  attr_reader :speed, :number_of_wagons, :type

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def speed_up(value)
    @speed += value
  end
  
  def stop
    @speed = 0
  end

  def add_wagon
    @number_of_wagons += 1 unless train_moving?
  end

  def remove_wagon
    @number_of_wagons -= 1 unless train_moving?
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


  private

  def train_moving?
    return false if @speed != 0
    true
  end

  def starting_station?
    @current_station_index == 0 ? true : false   
  end

  def finish_station?
    @current_station_index == @route_list.size - 1 ? true : false    
  end
end
