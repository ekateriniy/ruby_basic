class Wagon
  include Producer
  include Validation
  extend Accessors

  NUMBER_FORMAT = /^\d{7}$/

  attr_reader :type, :number
  attr_accessor :booked_space

  attr_accessor_with_history :belongs_to

  validate :number, :format, NUMBER_FORMAT

  def initialize(number, type, capacity)
    @number = number
    @type = type
    @capacity = capacity
    @available_space = capacity
    @booked_space = 0
    validate!
  end

  def available_space
    @capacity - @booked_space
  end

  def change_belongins(train)
    self.belongs_to = train if train.wagons.include?(self)
  end
end
