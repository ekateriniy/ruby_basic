class PassengerTrain < Train
  def self.all
    @@all.values.select { |train| train.type == :passenger }
  end
end
