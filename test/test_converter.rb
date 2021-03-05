require 'minitest/autorun'
require 'greeklish_iso843'

class GreeklishIso843::ConverterTest < Minitest::Test
  TEST_PAIRS = {
    'παιδιά' => 'paidia', # αι
    'φταίνε' => 'ftaine', # αί

    'ποιήμα' => 'poiima', # οι
    'αυτοί' => 'aftoi', # οί

    'όπου' => 'opou', # ου
    'αυτού' => 'aftou', # ού

    'τρέχει' => 'trechei', # ει
    'εκεί' => 'ekei', # εί

    'ντόμινο' => 'ntomino', # ντ

    'τσάι' => 'tsai', # τσ*
    'σκετσάκι' => 'sketsaki', # *τσ*
    'σκετς' => 'skets', # *τς

    'τζατζίκι' => 'tzatziki', # τζ

    'άγγελος' => 'angelos', # γγ

    'αγκώνας' => 'agkonas', # γκ

    'άγχος' => 'anchos', # γχ

    'ελέγξω' => 'elenxo', # γξ

    'έπαυα' => 'epava', # αυα
    'ναυάγιο' => 'navagio', # # αυά
    'έπαυε' => 'epave', # αυε
    # αυέ
    # αυη
    # αυή
    # αυι
    # αυί
    # αυï
    # αυΐ
    # αυο
    # αυό
    # αυυ
    # αυύ
    # αυϋ
    # αυΰ
    # αυω
    # αυώ
    # αυβ
    'αυγή' => 'avgi', # αυγ
    'άναυδος' => 'anavdos', # αυδ
    # αυζ
    'αυλή' => 'avli', # αυλ
    'θαυματουργός' => 'thavmatourgos', # αυμ
    'αυνανίζομαι' => 'avnanizomai', # αυν
    'αυριανισμός' => 'avrianismos', # αυρ

    'αυθεντικός' => 'afthentikos', # αυθ
    # αυκ
    'αυξητικός' => 'afxitikos', # αυξ
    'ναυπηγείο' => 'nafpigeio', # αυπ
    'αυστηρός' => 'afstiros', # αυσ
    'αυτό' => 'afto', # αυτ
    # αυφ
    'αυχένας' => 'afchenas', # αυχ
    # αυψ
    # *αυ

    'ναύαρχος' => 'navarchos', # αύα
    'αναπαύεται' => 'anapavetai', # αύε
    'αγαύη' => 'agavi', # αύη
    # αύι
    # αύï
    'παύουν' => 'pavoun', # αύο
    # αύυ
    # αύϋ
    'παύω' => 'pavo', # αύω
    # αύβ
    # αύγ
    # αύδ
    # αύζ
    'αύλακας' => 'avlakas', # αύλ
    'θαύμα' => 'thavma', # αύμ
    # αύν
    'αύριο' => 'avrio', # αύρ

    # αύθ
    # αύκ
    'αύξηση' => 'afxisi', # αύξ
    # αύπ
    'καύση' => 'kafsi', # αύσ
    'ταύτιση' => 'taftisi', # αύτ
    # αύφ
    # αύχ
    # αύψ
    # *αύ

    'σκόπευα' => 'skopeva', # ευα
    'Ευάγγελος' => 'Evangelos', # # ευά
    'ευεξία' => 'evexia', # ευε
    'ευέξαπτος' => 'evexaptos', # ευέ
    'ευημερία' => 'evimeria', # ευη
    'ευήκοος' => 'evikoos', # ευή
    # ευι
    # ευί
    # ευï
    # ευΐ
    'ευοίωνος' => 'evoionos', # ευο
    # ευό
    'ευυπόληπτος' => 'evypoliptos', # ευυ
    # ευύ
    # ευϋ
    # ευΰ
    'ευωδία' => 'evodia', # ευω
    # ευώ
    'Ευβοϊκός' => 'Evvoikos', # ευβ
    'ευγενικός' => 'evgenikos', # ευγ
    'ευδοκιμώ' => 'evdokimo', # ευδ
    # ευζ
    'ευλαβής' => 'evlavis', # ευλ
    'ευμετάβλητος' => 'evmetavlitos', # ευμ
    'ευνομία' => 'evnomia', # ευν
    'ευρύς' => 'evrys', # ευρ

    'ευθύς' => 'efthys', # ευθ
    'ευκατάστατος' => 'efkatastatos', # ευκ
    # ευξ
    'ευπατρίδης' => 'efpatridis', # ευπ
    'ευσεβής' => 'efsevis', # ευσ
    'ευτυχισμένος' => 'eftychismenos', # ευτ
    'ευφυής' => 'effyis', # ευφ
    'ευχάριστος' => 'efcharistos', # ευχ
    # ευψ
    'άνευ' => 'anef', # *ευ

    'Εύα' => 'Eva', # εύα
    'ρεύεται' => 'revetai', # εύε
    'εύηχος' => 'evichos', # εύη
    # εύι
    # εύï
    'Εύοσμος' => 'Evosmos', # εύο
    # εύυ
    # εύϋ
    'σκοπεύω' => 'skopevo', # εύω
    'Εύβοια' => 'Evvoia', # εύβ
    'εύγευστος' => 'evgefstos', # εύγ
    'Εύδηλος' => 'Evdilos', # εύδ
    'Εύζωνες' => 'Evzones', # εύζ
    'εύληπτος' => 'evliptos', # εύλ
    'μεταλλεύματα' => 'metallevmata', # εύμ
    'Εύνομος' => 'Evnomos', # εύν
    'εύρος' => 'evros', # εύρ

    'εύθυμος' => 'efthymos', # εύθ
    'εύκρατος' => 'efkratos', # εύκ
    'Εύξεινος' => 'Efxeinos', # εύξ
    'εύπορος' => 'efporos', # εύπ
    'εύσημα' => 'efsima', # εύσ
    'ρεύτηκε' => 'reftike', # εύτ
    # εύφ
    'εύχομαι' => 'efchomai', # εύχ
    # εύψ
    # *εύ

    # ηυα
    # ηυά
    # ηυε
    # ηυέ
    # ηυη
    # ηυή
    # ηυι
    # ηυί
    # ηυï
    # ηυΐ
    # ηυο
    # ηυό
    # ηυυ
    # ηυύ
    # ηυϋ
    # ηυΰ
    # ηυω
    # ηυώ
    # ηυβ
    # ηυγ
    # ηυδ
    # ηυζ
    # ηυλ
    # ηυμ
    # ηυν
    # ηυρ

    # ηυθ
    # ηυκ
    # ηυξ
    # ηυπ
    # ηυσ
    # ηυτ
    # ηυφ
    # ηυχ
    # ηυψ
    # *ηυ

    # ηύα
    # ηύε
    # ηύη
    # ηύι
    # ηύï
    # ηύο
    # ηύυ
    # ηύϋ
    # ηύω
    # ηύβ
    # ηύγ
    # ηύδ
    # ηύζ
    # ηύλ
    # ηύμ
    # ηύν
    # ηύρ

    # ηύθ
    # ηύκ
    # ηύξ
    # ηύπ
    # ηύσ
    # ηύτ
    # ηύφ
    # ηύχ
    # ηύψ
    # *ηύ

    'Μπάμπης' => 'Bampis', # μπ* *μπ*
    'κεμπάμπ' => 'kempab', # *μπ* *μπ

    'ξεσκεπάζω την ψυχοφθόρα σας βδελυγμία' => 'xeskepazo tin psychofthora sas vdelygmia' # pangram
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
