module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations 

    def validate(attr_name, validation_type, pattern = nil)
      @validations ||= []
      @validations.append({variable: attr_name, validation_type: validation_type, pattern: pattern})
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError => e
      e.message
      false
    end

    def validate!
      # получение значения проверяемого аргумента у инстанс-переменной
      self.class.validations.each do |validation|
        var = instance_variable_get("@#{validation[:variable]}".to_sym)

        case validation[:validation_type]
        when :presence
          raise "The value of #{validation[:variable]} must not be empty" if var.nil? || var == ''
        when :format
          raise 'Invalid format of the argument.' if var.to_s !~ validation[:pattern]
        when :type
          raise "Wrong type of the argument. Types must be the same." unless var.is_a? validation[:pattern]
        end
      end
    end
  end
end