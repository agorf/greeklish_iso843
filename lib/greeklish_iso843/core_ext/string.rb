require 'greeklish_iso843'

class String
  def to_greeklish
    GreeklishIso843::Converter.convert(self)
  end
end
