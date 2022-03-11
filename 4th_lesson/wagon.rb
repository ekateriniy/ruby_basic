class Wagon
  attr_reader :type, :number, :belongs_to

  def initialize(number, type)
    @number, @type = number, type 
  end

  def change_belongins(train)
    @belongs_to = train if train.wagons.include?(self)
  end
end