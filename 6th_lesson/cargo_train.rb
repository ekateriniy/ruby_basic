class CargoTrain < Train
  def self.all
    @@all.values.select {|train| train.type == :cargo}
  end
end