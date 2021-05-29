require 'minitest/autorun'

require 'greeklish_iso843'

class GreekTextTest < Minitest::Test
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
    'ναυάγιο' => 'navagio', # αυά
    'έπαυε' => 'epave', # αυε
    # αυέ
    # αυη
    'Ναυή' => 'Navi', # αυή
    # αυι
    'Δαυίδ' => 'David', # αυί
    # αυï
    # αυΐ
    'Βαταυοί' => 'Vatavoi', # αυο
    'αναπαυόταν' => 'anapavotan', # αυό
    # αυυ
    # αυύ
    # αυϋ
    # αυΰ
    # αυω
    # αυώ
    'Βαυβώ' => 'Vavvo', # αυβ
    'αυγή' => 'avgi', # αυγ
    'άναυδος' => 'anavdos', # αυδ
    # αυζ
    'αυλή' => 'avli', # αυλ
    'θαυματουργός' => 'thavmatourgos', # αυμ
    'αυνανίζομαι' => 'avnanizomai', # αυν
    'αυριανισμός' => 'avrianismos', # αυρ

    'αυθεντικός' => 'afthentikos', # αυθ
    'Καυκάσου' => 'Kafkasou', # αυκ
    'αυξητικός' => 'afxitikos', # αυξ
    'ναυπηγείο' => 'nafpigeio', # αυπ
    'αυστηρός' => 'afstiros', # αυσ
    'αυτό' => 'afto', # αυτ
    # αυφ
    'αυχένας' => 'afchenas', # αυχ
    # αυψ
    'ταυ' => 'taf', # *αυ

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
    'Αύγουστος' => 'Avgoustos', # αύγ
    'Κλαύδιος' => 'Klavdios', # αύδ
    # αύζ
    'αύλακας' => 'avlakas', # αύλ
    'θαύμα' => 'thavma', # αύμ
    'αποχαύνωση' => 'apochavnosi', # αύν
    'αύριο' => 'avrio', # αύρ

    'ενταύθα' => 'entaftha', # αύθ
    'Καύκασος' => 'Kafkasos', # αύκ
    'αύξηση' => 'afxisi', # αύξ
    'Ναύπακτος' => 'Nafpaktos', # αύπ
    'καύση' => 'kafsi', # αύσ
    'ταύτιση' => 'taftisi', # αύτ
    # αύφ
    'καύχημα' => 'kafchima', # αύχ
    # αύψ
    'Ησαύ' => 'Isaf', # *αύ

    'σκόπευα' => 'skopeva', # ευα
    'Ευάγγελος' => 'Evangelos', # ευά
    'ευεξία' => 'evexia', # ευε
    'ευέξαπτος' => 'evexaptos', # ευέ
    'ευημερία' => 'evimeria', # ευη
    'ευήκοος' => 'evikoos', # ευή
    'Λευιτικό' => 'Levitiko', # ευι
    'λευίτης' => 'levitis', # ευί
    # ευï
    # ευΐ
    'ευοίωνος' => 'evoionos', # ευο
    'μαζευόταν' => 'mazevotan', # ευό
    'ευυπόληπτος' => 'evypoliptos', # ευυ
    # ευύ
    # ευϋ
    # ευΰ
    'ευωδία' => 'evodia', # ευω
    'σκευών' => 'skevon', # ευώ
    'Ευβοϊκός' => 'Evvoikos', # ευβ
    'ευγενικός' => 'evgenikos', # ευγ
    'ευδοκιμώ' => 'evdokimo', # ευδ
    'Ευζώνων' => 'Evzonon', # ευζ
    'ευλαβής' => 'evlavis', # ευλ
    'ευμετάβλητος' => 'evmetavlitos', # ευμ
    'ευνομία' => 'evnomia', # ευν
    'ευρύς' => 'evrys', # ευρ

    'ευθύς' => 'efthys', # ευθ
    'ευκατάστατος' => 'efkatastatos', # ευκ
    'συνέντευξη' => 'synentefxi', # ευξ
    'ευπατρίδης' => 'efpatridis', # ευπ
    'ευσεβής' => 'efsevis', # ευσ
    'ευτυχισμένος' => 'eftychismenos', # ευτ
    'ευφυής' => 'effyis', # ευφ
    'ευχάριστος' => 'efcharistos', # ευχ
    'ευψυχία' => 'efpsychia', # ευψ
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
    'επιτεύξει' => 'epitefxei', # εύξ
    'εύπορος' => 'efporos', # εύπ
    'εύσημα' => 'efsima', # εύσ
    'ρεύτηκε' => 'reftike', # εύτ
    'εύφορη' => 'effori', # εύφ
    'εύχομαι' => 'efchomai', # εύχ
    'εύψυχη' => 'efpsychi', # εύψ
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
    'απηυδήσει' => 'apivdisei', # ηυδ
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
    'απηύδησε' => 'apivdise', # ηύδ
    # ηύζ
    # ηύλ
    # ηύμ
    # ηύν
    'εφηύρε' => 'efivre', # ηύρ

    'απηύθυνε' => 'apifthyne', # ηύθ
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

    'ξεσκεπάζω την ψυχοφθόρα σας βδελυγμία' => 'xeskepazo tin psychofthora sas vdelygmia', # pangram

    # Return any unrecognized character as-is. In the example below, μ is "micro sign"; not the Greek letter.
    'Πόσο καθοριστικός είναι ο  ρόλος που παίζουν οι διαπροσωπικές σχέσεις στη ζωή µας;' => 'Poso kathoristikos einai o  rolos pou paizoun oi diaprosopikes scheseis sti zoi µas;', # rubocop:disable Layout/LineLength

    'Θυμός' => 'Thymos',
    'ΘΥΜΟΣ' => 'THYMOS',
    'ΘΥΜΌΣ' => 'THYMOS',
    'θυμός' => 'thymos',
    'θΥΜΟΣ' => 'thYMOS',
    'Χελμός' => 'Chelmos',
    'ΧΕΛΜΟΣ' => 'CHELMOS',
    'ΧΕΛΜΌΣ' => 'CHELMOS',
    'χελμός' => 'chelmos',
    'χΕΛΜΟΣ' => 'chELMOS',
    'Ψάθα' => 'Psatha',
    'ΨΑΘΑ' => 'PSATHA',
    'ΨΆΘΑ' => 'PSATHA',
    'ψάθα' => 'psatha',
    'ψΑΘΑ' => 'psATHA',
    'παχύς' => 'pachys',
    'παΧύς' => 'paChys',
    'Ψάρι' => 'Psari'
  }.freeze

  TEST_PAIRS.each_with_index do |(greek, greeklish), index|
    index += 1

    name = greeklish.
      downcase.
      gsub(/[^\w[[:space:]]]+/, '').
      gsub(/[[:space:]]+/, '_')

    define_method "test_#{name}_#{index}" do
      assert_equal greeklish, GreeklishIso843::GreekText.to_greeklish(greek)
    end

    define_method "test_#{name}_with_trailing_space_#{index}" do
      assert_equal(
        "#{greeklish} ",
        GreeklishIso843::GreekText.to_greeklish("#{greek} ")
      )
    end

    define_method "test_#{name}_with_trailing_symbol_#{index}" do
      assert_equal(
        "#{greeklish}.",
        GreeklishIso843::GreekText.to_greeklish("#{greek}.")
      )
    end
  end
end
