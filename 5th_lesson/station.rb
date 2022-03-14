class Station
  include InstanceCounter
  
  attr_reader :trains, :name

  class << self
    attr_writer :all
    
    def all
      @all ||= {}
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.all[name] = self
    register_instance
  end

  def arrival(train)
    @trains << train
  end  

  def departure(train)
    @trains.delete(train)
  end

  def list_of_trains
    cargo = @trains.count { |train| train.type == :cargo }
    passenger = @trains.count { |train| train.type == :passenger }
    [cargo, passenger]
  end
end