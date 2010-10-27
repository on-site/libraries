module Enumerable

  # Call the given block for each element, creating a new hash
  # that uses the element as the key and the block's result as the value.
  def map_into_hash &block
    # The "reduce(:concat)" does a shallow flatten, so that blocks that
    # return arrays will do the Right Thing.
    Hash[*map {|x| [x, block.call(x)]}.inject([], &:concat)]
  end

  def map_keyvals_into_hash &block
    Hash[*map(&block).inject([], &:concat)]
  end

end
