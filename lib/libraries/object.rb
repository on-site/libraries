class Object

  def m regexp=nil
    m = (self.methods - Object.methods).sort
    return m.grep(/#{regexp}/) if regexp
    m
  end

end
