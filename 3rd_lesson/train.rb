class Train
  attr_reader :speed, :number_of_wagons, :type

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
    @current_station = nil
  end

  def speed_up
    @speed += 10
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
    @route_list = route.full_route
    @current_station = @route_list[0]
  end

  def move_forward
    @current_station += 1 if can_move?
  end

  def move_backwards
    @current_station -= 1 if can_move?
  end
    
#Возвращается массив из 3 элементов. Там, где вывести название станции невозможно(первая и последняя станции), будет nil
  def status
    result = []
    if @current_station == 0
      result << nil
    else
      result << @route_list[@current_station - 1]
    end

    result << @route_list[@current_station]
    if @current_station == @route_list.size - 1
      result << nil
    else
      result << @route_list[@current_station + 1]
    end
  end


  private

  def train_moving?
    return false if @speed != 0
    true
  end

#Проверка на нахождение поезда в крайних точках маршрута
  def can_move?
    return false if @current_station == 0
    return false if @current_station == @route_list.size - 1
    true    
  end
end
