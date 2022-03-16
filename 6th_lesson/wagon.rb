class Wagon
  include Producer
  attr_reader :type, :number, :belongs_to

  NUMBER_FORMAT = /^\d{7}$/

  def initialize(number, type)
    @number, @type = number, type
    validate_number!
    validate_type!
  end

  def change_belongins(train)
    @belongs_to = train if train.wagons.include?(self)
  end

  def valid?
    validate_number!
    validate_type!
    true
  rescue
    false
  end

  protected

  def validate_number!
    raise "Number has invalid format." if number.to_s !~ NUMBER_FORMAT
  end 

  def validate_type!
    raise "Type must be cargo or passenger" if type != :cargo && type != :passenger
  end
end