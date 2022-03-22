class CargoTrain < Train
  validate :number, :format, NUMBER_FORMAT
  
  def self.all
    @@all.values.select { |train| train.type == :cargo }
  end
end
