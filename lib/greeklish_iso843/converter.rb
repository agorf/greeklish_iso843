class GreeklishIso843::Converter
  GREEK_UPPER = 'ΑΆΒΓΔΕΈΖΗΉΘΙΊΪΚΛΜΝΞΟΌΠΡΣΤΥΎΫΦΧΨΩΏ'.freeze

  GREEK_LOWER = 'αάβγδεέζηήθιίϊΐκλμνξοόπρσςτυύϋΰφχψωώ'.freeze

  REPLACEMENTS = {
    'αι' => 'ai',
    'αί' => 'ai',
    'οι' => 'oi',
    'οί' => 'oi',
    'ου' => 'ou',
    'ού' => 'ou',
    'ει' => 'ei',
    'εί' => 'ei',
    'ντ' => 'nt',
    'τσ' => 'ts',
    'τζ' => 'tz',
    'γγ' => 'ng',
    'γκ' => 'gk',
    'γχ' => 'nch',
    'γξ' => 'nx',
    'αυ' => nil,
    'αύ' => nil,
    'ευ' => nil,
    'εύ' => nil,
    'ηυ' => nil,
    'ηύ' => nil,
    'μπ' => nil,
    'α' => 'a',
    'ά' => 'a',
    'β' => 'v',
    'γ' => 'g',
    'δ' => 'd',
    'ε' => 'e',
    'έ' => 'e',
    'ζ' => 'z',
    'η' => 'i',
    'ή' => 'i',
    'θ' => 'th',
    'ι' => 'i',
    'ί' => 'i',
    'ϊ' => 'i',
    'ΐ' => 'i',
    'κ' => 'k',
    'λ' => 'l',
    'μ' => 'm',
    'ν' => 'n',
    'ξ' => 'x',
    'ο' => 'o',
    'ό' => 'o',
    'π' => 'p',
    'ρ' => 'r',
    'σ' => 's',
    'ς' => 's',
    'τ' => 't',
    'υ' => 'y',
    'ύ' => 'y',
    'ϋ' => 'y',
    'ΰ' => 'y',
    'φ' => 'f',
    'χ' => 'ch',
    'ψ' => 'ps',
    'ω' => 'o',
    'ώ' => 'o'
  }.freeze

  BLANK_REGEXP = /\A[[:space:]]*\z/.freeze

  attr_reader :text

  def self.convert(text)
    new(text).convert
  end

  def initialize(text)
    @text = text
  end

  def convert
    text.gsub(/#{REPLACEMENTS.keys.join('|')}/i) do |match|
      match_data = Regexp.last_match
      replacement = REPLACEMENTS[match.downcase]

      if replacement
        greeklish = replacement
        greek = match + match_data.post_match[0].to_s
      elsif match.casecmp?('μπ')
        greeklish =
          if present?(match_data.pre_match) &&
              GREEK_LOWER[match_data.pre_match[0].downcase] &&
              present?(match_data.post_match) &&
              GREEK_LOWER[match_data.post_match[0].downcase]
            'mp'
          else
            'b'
          end
        greek = match
      elsif match.casecmp?('τς')
        greeklish = 'ts'
        greek = match
      else
        index = match_data.offset(0)[0]
        greeklish = REPLACEMENTS[match[0].downcase] +
          ('αβγδεζηλιμνορω'[text[index...index + 2].downcase] ? 'v' : 'f')
        greek = match
      end

      fix_case(greeklish, greek)
    end
  end

  private def capitalized?(text)
    GREEK_UPPER[text[0]]
  end

  private def fix_case(greeklish, greek)
    if capitalized?(greek[0])
      if greek.length == 1 || capitalized?(greek[1])
        greeklish.upcase
      else
        greeklish[0].upcase + greeklish[1..-1]
      end
    else
      greeklish
    end
  end

  private def present?(text)
    text.to_s !~ BLANK_REGEXP
  end
end
