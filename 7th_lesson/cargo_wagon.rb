class CargoWagon < Wagon
  attr_accessor :available_space, :occupied_space

  def initialize(number, type, capacity)
    @capacity = capacity
    self.available_space = capacity
    self.occupied_space = 0
    super(number, type)
  end

  def occupy_space(cargo_volume)
    check_available_space!(cargo_volume)
    self.occupied_space += cargo_volume
    self.available_space -= cargo_volume
  end

  private

  def check_available_space!(cargo_volume)
    raise 'No available space.' if available_space < cargo_volume
  end
end