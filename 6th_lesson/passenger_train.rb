class  PassengerTrain < Train
  def initialize(name)
    super
    @type = :passenger
  end
end