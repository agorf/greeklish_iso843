require 'greeklish_iso843'

class String
  def to_greeklish
    GreeklishIso843::GreekText.to_greeklish(self)
  end
end
