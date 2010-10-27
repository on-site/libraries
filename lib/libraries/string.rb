class String

  def strip_with_arg_support!(char=nil)
    if char.present?
      m = char.each_char.inject('') {|r,c| r+=(c =~ /[\*\.\[\]\^\$\?\\\|\=\+\:\/\(\)]/ ? "\\" : "") + c}
      self.gsub!(/^[#{m}]*(.*?)[#{m}]*$/,'\1')
    else
      strip_without_arg_support!
    end
  end
  alias_method_chain :strip!, :arg_support

  def strip_with_arg_support(char=nil)
    char.present? ? self.dup.strip!(char) : strip_without_arg_support
  end
  alias_method_chain :strip, :arg_support

  # In the sense of normal characters only, it also downcases the string
  # Can be used, for example, in file names and css classes
  def normalize!
    return if normalize.blank?
    self.gsub!(/[^A-Z0-9]/i, '_')
    self.squeeze!("_")
    self.strip!("_")
    self.downcase!
  end

  def normalize
    self.gsub(/[^A-Z0-9]/i, '_').squeeze("_").strip("_").downcase
  end

end
