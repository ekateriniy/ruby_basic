class PassengerWagon < Wagon
  def initialize(name)
    super
    @type = :passenger
  end
end