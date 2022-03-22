class CargoWagon < Wagon
  validate :number, :format, NUMBER_FORMAT
  
  def book_space(cargo_volume)
    check_available_space!(cargo_volume)
    @booked_space += cargo_volume
    @available_space -= cargo_volume
  end

  private

  def check_available_space!(cargo_volume)
    raise 'No available space.' if available_space < cargo_volume
  end
end
