module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances = self.all.size
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
