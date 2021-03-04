require 'minitest/autorun'
require 'greeklish_iso843'

class GreeklishIso843::ConverterTest < Minitest::Test
  TEST_PAIRS = {
    'Μπάμπης' => 'Bampis',
    'Άγγελος' => 'Angelos',
    'Ευάγγελος' => 'Evangelos',
    'άνευ αποδοχών' => 'anef apodochon',
    'εγγύηση' => 'engyisi',
    'Εύβοια' => 'Evvoia',
    "εφ' όλης της ύλης" => "ef' olis tis ylis"
  }.freeze

  TEST_PAIRS.each do |greek, greeklish|
    name = greeklish.
      downcase.
      gsub(/[^\w[[:space:]]]+/, '').
      gsub(/[[:space:]]+/, '_')

    define_method "test_#{name}" do
      assert_equal GreeklishIso843::Converter.convert(greek), greeklish
    end
  end
end
