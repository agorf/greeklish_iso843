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

  REPLACEMENTS_REGEXP = /#{REPLACEMENTS.keys.join('|')}/i.freeze

  attr_reader :text

  def self.convert(text)
    new(text).convert
  end

  def initialize(text)
    @text = text
  end

  def convert
    text.gsub(REPLACEMENTS_REGEXP) do |match|
      match_data = Regexp.last_match
      prev_char = match_data.pre_match[-1]&.downcase
      next_char = match_data.post_match[0]&.downcase
      greeklish = REPLACEMENTS[match.downcase]
      greek = match

      if greeklish
        greek = match + next_char.to_s
      elsif match.casecmp?('μπ')
        greeklish =
          if prev_char && GREEK_LOWER[prev_char] && # *μπ
              next_char && GREEK_LOWER[next_char] # and μπ*
            'mp'
          else # μπ* or *μπ
            'b'
          end
      elsif match.casecmp?('τς')
        greeklish = 'ts'
      else # αυ αύ ευ εύ ηυ ηύ
        greeklish =
          REPLACEMENTS[match[0].downcase] +
          if next_char && 'αάεέηήιίϊΐοόυύϋΰωώβγδζλμνρ'[next_char]
            'v'
          else
            'f'
          end
      end

      fix_case(greeklish, greek)
    end
  end

  private def capitalized?(text)
    GREEK_UPPER[text[0]]
  end

  private def fix_case(greeklish, greek)
    if !capitalized?(greek[0])
      return greeklish
    end

    if greek.length == 1 || capitalized?(greek[1])
      greeklish.upcase
    else
      greeklish[0].upcase + greeklish[1..-1]
    end
  end
end
