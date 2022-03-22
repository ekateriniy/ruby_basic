module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var = instance_variable_get(var_name)

      # если значение переменной nil - ей присваивается пустой массив
      define_method(name) { var.nil? ? instance_variable_set(var_name, []) : var[-1] }

      define_method("#{name}=".to_sym) do |value|
        var = instance_variable_set(var_name, []) if var.nil? || var.empty?
        instance_variable_set(var_name, var.append(value))
      end

      # инстанс-метод  <имя_атрибута>_history, который возвращает массив всех значений данной переменной.
      define_method("#{name}_history".to_sym) { instance_variable_get(var_name) }
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    var_name = "@#{attr_name}".to_sym

    define_method(attr_name) { instance_variable_get(var_name) }

    define_method("#{attr_name}=".to_sym) do |value|
      if value.class == attr_class
        instance_variable_set(var_name, value)
      else
        raise 'Wrong type. Variable and value must have the same type'
      end
    end
  end
end
