class CargoWagon < Wagon
  def initialize(name)
    super
    @type = :cargo
  end
end