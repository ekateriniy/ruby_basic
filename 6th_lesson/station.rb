class Station
  include InstanceCounter

  @@all = {}  

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    validate_name!
    self.class.all[name] = self
    register_instance
  end

  def self.all
    @@all
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

  def valid?
    validate_name!
    true
  rescue
    false
  end

  private

  def validate_name!
    raise "Name must be a string." unless name.is_a? String
  end 
end