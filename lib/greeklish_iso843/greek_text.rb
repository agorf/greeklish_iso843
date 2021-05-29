class GreeklishIso843::GreekText
  GREEK_UPPER = 'ΑΆΒΓΔΕΈΖΗΉΘΙΊΪΚΛΜΝΞΟΌΠΡΣΤΥΎΫΦΧΨΩΏ'.freeze

  GREEK_LOWER = 'αάβγδεέζηήθιίϊΐκλμνξοόπρσςτυύϋΰφχψωώ'.freeze

  GREEK_VOWELS = 'αάεέηήιίϊΐοόυύϋΰωώ'.freeze

  PAIRS_FOR_V_OR_F = %w[αυ αύ ευ εύ ηυ ηύ].freeze

  GREEK_LETTERS_AFTER_V = "#{GREEK_VOWELS}βγδζλμνρ".freeze

  GREEK_LETTERS_AFTER_F = 'θκξπστφχψ'.freeze

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

  REPLACEMENT_KEYS_REGEXP = /#{REPLACEMENTS.keys.join('|')}/i.freeze

  class Error < StandardError; end

  class UnhandledCaseError < Error; end

  attr_reader :text

  def self.to_greeklish(text)
    new(text).to_greeklish
  end

  def initialize(text)
    @text = text
  end

  def to_greeklish
    text.gsub(REPLACEMENT_KEYS_REGEXP) do |match|
      greeklish = REPLACEMENTS[match.downcase] ||
        convert_pair(match, Regexp.last_match)

      next match if greeklish.nil? # Unhandled case. Return as-is.

      fix_case(greeklish, match, Regexp.last_match)
    end
  end

  private def convert_pair(match, match_data)
    return 'ts' if match.casecmp?('τς')

    next_char = match_data.post_match[0]&.downcase

    if match.casecmp?('μπ')
      prev_char = match_data.pre_match[-1]&.downcase
      return convert_mp_or_b(prev_char, next_char)
    end

    if PAIRS_FOR_V_OR_F.any? { |pair| match.casecmp?(pair) }
      return convert_pair_for_v_or_f(match, next_char)
    end

    match # Unhandled case. Return as-is.
  end

  private def fix_case(greeklish, match, match_data)
    if !uppercase?(match[0])
      return greeklish
    end

    if match.size == 1
      return fix_case_single_letter_match(greeklish, match_data)
    end

    if match.size == 2
      return fix_case_two_letter_match(greeklish, match)
    end

    raise UnhandledCaseError
  end

  private def fix_case_single_letter_match(greeklish, match_data)
    if greeklish.size == 1
      return greeklish.upcase
    end

    if greeklish.size == 2 # match is one of Θ, Χ, Ψ
      return fix_case_th_ch_ps(greeklish, match_data)
    end

    raise UnhandledCaseError
  end

  private def fix_case_two_letter_match(greeklish, match)
    if uppercase?(match[1])
      return greeklish.upcase
    end

    greeklish[0].upcase + greeklish[1].to_s
  end

  private def fix_case_th_ch_ps(greeklish, match_data)
    next_char = match_data.post_match[0]

    if next_char.nil? ||
        next_char !~ REPLACEMENT_KEYS_REGEXP ||
        !uppercase?(next_char)
      return greeklish[0].upcase + greeklish[1].to_s
    end

    greeklish.upcase
  end

  private def convert_mp_or_b(prev_char, next_char)
    if prev_char && lowercase?(prev_char) && # *μπ
        next_char && lowercase?(next_char) # and μπ*
      'mp'
    else # μπ* or *μπ
      'b'
    end
  end

  private def convert_pair_for_v_or_f(match, next_char)
    v_or_f = convert_v_or_f(next_char)

    if v_or_f.nil?
      raise UnhandledCaseError # Should never happen
    end

    REPLACEMENTS[match[0].downcase] + v_or_f
  end

  private def uppercase?(char)
    GREEK_UPPER[char]
  end

  private def lowercase?(char)
    GREEK_LOWER[char]
  end

  private def convert_v_or_f(next_char)
    if next_char.nil? ||
        GREEK_LETTERS_AFTER_F[next_char] ||
        next_char !~ REPLACEMENT_KEYS_REGEXP
      return 'f'
    end

    'v' if GREEK_LETTERS_AFTER_V[next_char]
  end
end
