class Hash

  def recursive_symbolize_keys!
    symbolize_keys!
    # symbolize each hash in .values
    values.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    # symbolize each hash inside an array in .values
    values.select{|v| v.is_a?(Array) }.flatten.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    self
  end

  # deep lookup a nested hash without failing on non-existing keys
  # in which case returns and empty hash
  # This will only work on NESTED hashes, something like:
  # h = {:a => {:b => {:c => 3}}}
  # h.lookup(:a,:b,:c) => 3
  # h.lookup(:a,:b) => {:c => 3}
  # h.lookup(:a,:b,:X) => nil
  # h.lookup(:a,:X,:Y) => nil
  # h.lookup(:W,:T,:F) => nil
  def nested_lookup(*keys)
    keys.inject(self){ |h,k| (h || {}).fetch(k,nil) } rescue nil
  end

  # Takes a hash argument of old, new pairs
  # Returns hash with keys renamed
  def rename_keys!(keys_hash)
    keys_hash.each do |old, new|
      self[new] = self.delete(old)
    end
    self
  end

  def rename_keys(keys_hash)
    self.dup.rename_keys!(keys_hash)
  end

  # map from a block
  def map_into_hash(&block)
    Hash[*map {|x| [x[0], block.call(x)]}.inject([], &:concat)]
  end

  def parent_to?(*args)
    return self.slice(*args.first.keys) == args.first if args.size == 1 && args.first.is_a?(Hash)
    args.each_pair do |key, value|
      return false unless self[key].to_s == value.to_s
    end
    true
  end

  ############################################################
  # The following methods take as an argument, a list of keys
  # See the specs for examples

  def all_keys?(*keys)
    keys.all? {|k| has_key? k}
  end

  def any_key?(*keys)
    keys.any? {|k| has_key? k}
  end

  def all_values?(*keys)
    keys.all?{|k| self[k].present?}
  end

  def any_value?(*keys)
    keys.any?{|k| self[k].present?}
  end

  ############################################################

end
