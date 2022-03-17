class PassengerWagon < Wagon
  attr_accessor :booked_seats, :available_seats

  def initialize(number, type, seats)
    @seats = seats
    self.booked_seats = 0
    self.available_seats = seats
    super(number, type)
  end

  def book_seat
      check_availiable_seats!
      self.booked_seats += 1
      self.available_seats -= 1
  end

  private

  def check_availiable_seats!
    raise 'No available seats.' if available_seats < 1
  end
end