require 'facets'

class Array
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
end
