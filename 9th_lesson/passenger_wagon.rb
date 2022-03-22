class PassengerWagon < Wagon
  validate :number, :format, NUMBER_FORMAT
  
  def book_seat
    check_availiable_seats!
    @booked_space += 1
    @available_space -= 1
  end

  private

  def check_availiable_seats!
    raise 'No available seats.' if available_space < 1
  end
end
