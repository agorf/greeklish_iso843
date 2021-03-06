class GreeklishIso843::GreekText
  GREEK_UPPER = 'ΑΆΒΓΔΕΈΖΗΉΘΙΊΪΚΛΜΝΞΟΌΠΡΣΤΥΎΫΦΧΨΩΏ'.freeze

  GREEK_LOWER = 'αάβγδεέζηήθιίϊΐκλμνξοόπρσςτυύϋΰφχψωώ'.freeze

  GREEK_VOWELS = 'αάεέηήιίϊΐοόυύϋΰωώ'.freeze

  GREEK_LETTERS_AFTER_V = "#{GREEK_VOWELS}βγδζλμνρ".freeze

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

  def self.to_greeklish(text)
    new(text).to_greeklish
  end

  def initialize(text)
    @text = text
  end

  def to_greeklish
    text.gsub(REPLACEMENTS_REGEXP) do |match|
      match_data = Regexp.last_match
      next_char = match_data.post_match[0]&.downcase
      greeklish = REPLACEMENTS[match.downcase]
      greek = match

      if greeklish
        greek = match + next_char.to_s
      else
        greeklish = convert_to_greeklish(match, match_data, next_char)
      end

      fix_case(greeklish, greek)
    end
  end

  private def capitalized?(text)
    GREEK_UPPER[text[0]]
  end

  private def lowercase_char?(char)
    GREEK_LOWER[char]
  end

  private def fix_case(greeklish, greek)
    return greeklish if !capitalized?(greek[0])

    if greek.length == 1 || capitalized?(greek[1])
      greeklish.upcase
    else
      greeklish[0].upcase + greeklish[1..-1]
    end
  end

  private def convert_mp_or_b(prev_char, next_char)
    if prev_char && lowercase_char?(prev_char) && # *μπ
        next_char && lowercase_char?(next_char) # and μπ*
      'mp'
    else # μπ* or *μπ
      'b'
    end
  end

  private def convert_v_or_f(next_char)
    if next_char && GREEK_LETTERS_AFTER_V[next_char]
      'v'
    else
      'f'
    end
  end

  private def convert_to_greeklish(match, match_data, next_char)
    return 'ts' if match.casecmp?('τς')

    if match.casecmp?('μπ')
      prev_char = match_data.pre_match[-1]&.downcase
      return convert_mp_or_b(prev_char, next_char)
    end

    # αυ αύ ευ εύ ηυ ηύ
    REPLACEMENTS[match[0].downcase] + convert_v_or_f(next_char)
  end
end