class Array

  def each_pair
    self.in_groups_of(2).each { |g| yield g.first, g.last }
  end

  # delete all passed element and return the array after delete
  def delete!(*args)
    self.tap { |a| a.delete_if { |e| args.include? e } }
  end

  # same as delete! but does not alter self
  def without(*args)
    self.dup.tap { |dup| dup.delete!(*args) }
  end

end
