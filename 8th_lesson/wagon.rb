class Wagon
  include Producer

  NUMBER_FORMAT = /^\d{7}$/

  attr_reader :type, :number, :belongs_to
  attr_accessor :booked_space

  def initialize(number, type, capacity)
    @number = number
    @type = type
    @capacity = capacity
    @available_space = capacity
    @booked_space = 0
    validate_number!
    validate_type!
  end

  def available_space
    @capacity - @booked_space
  end

  def change_belongins(train)
    @belongs_to = train if train.wagons.include?(self)
  end

  def valid?
    validate_number!
    validate_type!
    true
  rescue StandardError
    false
  end

  protected

  def validate_number!
    raise 'Number has invalid format.' if number.to_s !~ NUMBER_FORMAT
  end

  def validate_type!
    raise 'Type must be cargo or passenger' if type != :cargo && type != :passenger
  end
end
