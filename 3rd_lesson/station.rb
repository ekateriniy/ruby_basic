class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains << train
  end  

  def departure(train)
    @trains.delete(train)
  end

  def list_of_trains
    cargo = @trains.count { |train| train.type == 'грузовой' }
    passenger = @trains.count { |train| train.type == 'пассажирский' }
    [cargo, passenger]
  end
end

