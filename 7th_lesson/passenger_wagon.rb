class PassengerWagon < Wagon
  def book_seat
      check_availiable_seats!
      self.booked_space += 1
      self.available_space -= 1
  end

  private

  def check_availiable_seats!
    raise 'No available seats.' if available_space < 1
  end
end