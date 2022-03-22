module Producer
  attr_reader :producer_company

  def assign_producer_company(company)
    self.producer_company = company
  end

  def show_company
    producer_company
  end

  protected

  attr_writer :producer_company
end
