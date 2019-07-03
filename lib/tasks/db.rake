# coding: utf-8
namespace :db do
  desc "Create database IPa for Pronunciation page"
  # Database default IPA
  list_ipa = [
    {"ʌ" => "-	Although variable, the tongue is in the center of the oral cavity.
      -	The jaw is slightly lowered, although its position varies depending on phonetic context.
      -	The lips are unrounded.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ɑ" => "-	The tongue body is position back and low in the oral cavity.
      -	The mandible is lowered more than the rest of the back vowel.
      -	The lips are unrounded and wipe open.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"æ" => "-	The tongue is positioned slightly forward and low in the oral cavity, with the tip positioned behind the lower teeth.
      -	The mandible is lowered more than for any other front vowel.
      -	The lips are unrounded but may be retracted.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"e" => "-	The tongue is positioned forward and high in the oral cavity with the sides in contact with the teeth laterally and the tip positioned behind the lower teeth.
      -	The mandible is elevated.
      -	The lips are unrounded, and may be retracted.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ə" => "-	Although variable, the tongue is slightly above the neutral position with some bunching in the palatal region.
      -	The mandible is slightly lowered.
      -	The lips are usually rounded.
      -	The lips are usually rounded.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ɜr" => "-	Although variable, the tongue is slightly above the neutral position with some bunching in the palatal region.
      -	The mandible is slightly lowered.
      -	The lips are usually rounded.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ər" => "-	The first of this diphthong is more open than the short vowel /e/ in pen, the glides to /ə/. The lips remain neutrally open.
      -	Suggestion: most native speakers use /æ/ as the starting point of this diphthong.
      "},
    {"ʊr" => "-	The produce /ʊə/, the front of the back of the tongue is raised and then it moves towards /ə/.
      -	/ʊə/ is open mispronounced as /u:ə/.
      -	Suggestion: Practice the /ʊ/ sound first and then practice the glide from /ʊ/ to /ə/.
      "},
    {"ɪ" => "-	The tongue is positioned forward and slightly lower in the oral cavity than for /i:/, with the sides in contact with the teeth laterally and the tip positioned behind the lower teeth.
      -	The mandible is slightly lower than for /i:/.
      -	The lips are unrounded.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"i:" => "-	The tongue is positioned forward and high in the oral cavity with the sides in contact with the teeth laterally and the top positioned behind the lower teeth.
      -	The mandible is elevated.
      -	The lips are unrounded, and may be retracted.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ɑr" => "-	The tongue is positioned slightly forward and low in the oral cavity, with the tip positioned behind the lower teeth.
      -	The mandible is lowered more than for any other front vowel.
      -	The lips are unrounded but may be retracted.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ɔr" => "-	The tongue is position back and in a low-mid position with respect to height.
      -	The mandible is slightly lowered.
      -	The lips are rounded, but less than/u/ or /o/.
      -	The vocal folds are adducted vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"ʊ" => "-	The tongue body is back and elevated into a mid-high position with contact against the upper molars, while the tongue root is not as retracted as other back vowels.
      -	The mandible is elevated but may lower slightly.
      -	The lips are usually rounded and protruded.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"u:" => "-	The tongue body is elevated into a high and back position with contact against the upper molars, while the tongue root is advanced to open the pharyngeal airway.
      -	The mandible is elevated.
      -	The lips are rounded and protruded.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"aɪ" => ["pint", "islet", "island", "align", "asign", "shine", "ripe", "cite", "fine", "hide", "deny", "try", "apply", "fly", "ally"]},
    {"aʊ" => "-	The tongue moves from a low back position to a mid-high back position.
      -	The tongue begins back and low in the oral cavity and moves to a mid-high front position.
      -	The mandible elevates during sound production.
      -	The lips move from an unrounded to a rounded configuration.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"eɪ" => "-	Lips: Not rounded, relaxed.
      -	Tongue: Tense, moves from the mid-high to high position.
      "},
    {"oʊ" => ["go", "hole", "cold", "bold", "ago", "boat", "boast", "toast", "oat", "low", "show", "arrow", "flow", "borrow", "shoulder", "boulder", "poultice", "poultry", "soul"]},
    {"ɔɪ" => "-	The tongue moves from a low-mid back position to a mid-high front position. The lips move from a rounded to an unrounded configuration.
      -	The mandible is in a relatively neutral position.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"er" => "-	The first of this diphthong is more open than the short vowel /e/ in pen, the glides to /ə/. The lips remain neutrally open.
      -	Suggestion: most native speakers use /æ/ as the starting point of this diphthong.
      "},
    {"ɪr" => "-	It’s a diphthong – which means you move from one vowel position to another in one syllable.
      -	Start in a close-mid position around the /ɪ/ vowel, and move to a mid-central position /ə/.
      "},
    {"b" => "-	The lips are brought together to obstruct the oral cavity.
      -	Tongue position may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      -	Air pressure build up behind obstruction released by parting lips, producing noise burst.
      "},
    {"p" => "-	The lips are brought together to obstruct oral cavity.
      -	Tongue position may vary depending on phonetic context.
      -	The vocal folds are abducted.
      -	The velopharyngeal port is closed.
      -	Air pressure built up behind obstruction is released by parting lips, producing noise burst.
      "},
    {"f" => "-	The inner border of the lower lop contacts the upper teeth to create a constriction.
      -	Tongue position may vary depending on phonetic context.
      -	The vocal folds are abducted.
      -	The velopharyngeal port is closed.
      -	Air forced through the lower lip/upper teeth constriction creates audible frictional turbulence.
      "},
    {"v"=> "-	The inner border of the lower lip contacts the upper teeth to create a constriction.
      -	Tongue position may vary depending on phonetic context.
      -	The vocal folds are adducted and vibrating.
      -	The velopharyngeal port is closed.
      -	Air forced through the lower lip the upper teeth constriction creates audible frictional turbulence.
      "},
    {"t" => "-	The front and sides of the tongue contact the alveolar ridge anteriorly and laterally.
      -	Lip configuration may vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	The vocal folds are abducted.
      -	Air pressure built up behind obstruction is released by lowering the tongue, producing noise burst.
      "},
    {"d" => "-	The front and sides of the tongue contact the alveolar ridge anteriorly and laterally.
      -	Lip configuration may vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	The vocal folds are abducted and vibrating.
      -	Air pressure built up behind obstruction is released by lowering the tongue, producing noise burst.
      "},
    {"l" => "-	The tongue tip and a portion of the tongue blade contact the alveolar ridge in the midline.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      -	Acoustic energy radiates laterally, around midline closure.
      "},
    {"g" => "-	The tongue dorsum is elevated and retracted to contract the back of the hard palate and the soft palate, depending on phonetic context.
      -	Lip configuration may vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	The vocal folds are abducted and vibrating.
      -	Air pressure built up behind abstraction is released by lowering the tongue, producing noise burst.
      "},
    {"h" => "-	The vocal folds are partially abducted to create a narrowing of the airway.
      -	Lip and tongue configuration vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	Air forced under pressure through the laryngeal narrowing creates audible frictional turbulence.
      "},
    {"k" => "-	The tongue dorsum is elevated and retracted to contact the back of the hard palate and the soft palate, depending on phonetic context.
      -	Lip configuration may vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	The vocal folds are abducted.
      -	Air pressure built up behind obstruction is released by lowering the tongue, producing noise burst.
      "}, 
    {"m" => "-	The lips are brought together to obstruct the oral cavity.
      -	Tongue position may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is open, allowing acoustic energy and airflow to pass through the nose.
      "},
    {"n" => "-	The font and sides of the tongue contact the alveolar ridge anteriorly and laterally to obstruct the oral cavity.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is open, allowing acoustic energy and airflow to pass through the nose.
      "},
    {"ŋ" => "-	The tongue dorsum is elevated and retracted to contact the soft palate, obstructing the oral cavity.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is open, allowing acoustic energy and airflow to pass through the nose.
      "},
    {"s" => "-	The apex and blade of the tongue are elevated into contact with the hard palate, leaving a narrow midline groove open.
      -	The tongue tip may be raised or lowered behind the upper teeth.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted.
      "},
    {"ʃ" => "-	The tip and blade of the tongue are elevated into contact with the sides of the palate and teeth, leaving a fattened midline groove along the upper surface of the tongue.
      -	The lips may be slightly rounded and protruded, but the degree varies with phonetic context.
      -	The vocal folds are abducted.
      -	The velopharyngeal port is closed.
      -	Air forced under pressure along the flattened midline groove and across the teeth creates audible frictional turbulence.
      "},
    {"z" => "-	The apex and blade of the tongue are elevated into contact with the hard palate, leaving a narrow midline groove open.
      -	The tongue tip may be raised or lowered behind the upper teeth.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      -	Air forced under pressure along midline groove creates audible frictional turbulence.
      "},
    {"ʒ" => "-	The tip and blade of the tongue is elevated into contact with the sides of the palate and teeth, leaving a flattened midline groove along the upper surface of the tongue.
      -	The lips may be slightly rounded and protruded, but the degree varies with phonetic context.
      -	The vocal folds are abducted.
      -	The velopharyngeal port is closed.
      -	Air forced under pressure along the flattened midline groove and across the teeth creates audible frictional turbulence.
      "},
    {"tʃ" => "-	The front and sides of the tongue contact the alveolar ridge anteriorly and laterally.
      -	Lip configuration may vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	The vocal folds are abducted.
      -	Air pressure built up behind obstruction is releases by lowering the tongue, and is followed by frictional noise associated with fricative portion of the sound.
      "},
    {"θ" => "- Tongue tip is brought forward just below the upper teeth (interdental) or into slight contact with the back of the upper teeth (dental) to create a construction between the tongue tip and upper teeth.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted.
      -	The velopharyngeal port is closed.
      -	Air forced between tongue surface and cutting edge of the upper teeth (interdental) or inside surface of the teeth (dental) creates audible frictional turbulence.
      "},
    {"ð" => "-	Tongue tip is brought forward just below the upper teeth (interdental) or into slight contact with back of the upper teeth (dental) to create a construction between the tongue tip and upper teeth.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      -	Air forced between tongue surface and the cutting edge of the upper teeth (interdental) or inside surface of the teeth (dental) creates audible frictional turbulence.
      "},
    {"r" => "- The tongue is elevated towards the hard palate in a bunched configuration.
      -	The front of the tongue is usually close to the alveolar ridge but may be retroflexed.
      -	The lips are slightly unrounded.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"w" => "- The tongue begins in a high back position similar to the vowel /u/, but the airways are slightly more constricted.
      -	The tongue glides from its start position to a more open position for the following vowel. Lips are rounded and protruded, then move to the configuration for the following vowel.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"j" => "- The tongue begins in a high front position similar to the vowel /i/, but the airway is slightly more constricted.
      - The tongue glides from its start position to a more open position for the following vowel.
      -	Lip configuration may vary depending on phonetic context.
      -	The vocal folds are abducted and vibrating.
      -	The velopharyngeal port is closed.
      "},
    {"dʒ" => "-	The front and sides of the tongue contact the alveolar ridge anteriorly and laterally.
      -	Lip configuration may vary depending on phonetic context.
      -	The velopharyngeal port is closed.
      -	The vocal folds are abducted.
      -	Air pressure built up behind obstruction is released by lowering the tongue, and is flowering the tongue and is followed by frictional noise associated with fricative portion of the sound.
      "}
  ]
  task ipa: :environment do
    Ipa.all.each do |k|
      k.destroy
    end
    
    list_ipa.each do |ipas|
      ipas.each do |key, value|
        Ipa.create(name: key, gif: key.to_s.gsub(/:/, ""), list_words: value)
      end
    end
  end

end
