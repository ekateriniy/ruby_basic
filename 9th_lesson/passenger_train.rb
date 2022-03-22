class PassengerTrain < Train
  validate :number, :format, NUMBER_FORMAT
  
  def self.all
    @@all.values.select { |train| train.type == :passenger }
  end
end
