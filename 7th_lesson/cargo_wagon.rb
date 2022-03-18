class CargoWagon < Wagon
  def book_space(cargo_volume)
    check_available_space!(cargo_volume)
    self.booked_space += cargo_volume
    self.available_space -= cargo_volume
  end

  private

  def check_available_space!(cargo_volume)
    raise 'No available space.' if available_space < cargo_volume
  end
end