require 'facets'

class Object
  def atom?
    self.is_a?(Symbol) || self.is_a?(String) || self.is_a?(Numeric)
  end

  def sexpr?
    self.atom? || self.list?
  end
end

class Array
  def list?
    self == [] ? true :
      (self.car.atom? || self.car.list?) && (self.cdr.list?)
  end

  def car
    self.first
  end

  def cdr
    self[1..-1]
  end

  def cr
    self
  end

  def method_missing(method, *args, &block)
    if method =~ /^c((?:a|d)+)r$/
      f, call_list = $1.split(//, 2)
      self.send("c#{call_list}r").send("c#{f}r")
    end
  end

  def cons(sexpr)
    self.clone.unshift(sexpr)
  end
end
