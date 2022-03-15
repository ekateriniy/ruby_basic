class CargoTrain < Train
  def self.all
    @@all.values.select {|train| train.type == :cargo}
  end

  def initialize(name)
    super
    @type = :cargo
  end
end