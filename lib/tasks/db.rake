# coding: utf-8
namespace :db do
  desc "Create database IPa for Pronunciation page"
  # Database default IPA
  list_ipa = [
    {"ʌ" => ["monkey", "wonder", "cover", "discover", "luck", "donut", "scrub", "subtitle", "umbrella", "rough", "tough", "touch", "young", "youngster", "bump", "monk", "blood"]},
    {"ɑ" => ["blot", "cot", "clot", "jot", "got", "hot", "knot", "lot", "not", "plot", "pot", "rot", "shot", "spot", "tot", "lock", "clock", "rock", "flock", "mock", "shock", "dock", "knock", "stock", "block", "hall", "all", "small", "tall", "call", "fall", "install", "mall", "ball", "pall", "bought", "brought", "fought", "ought", "sought", "saw", "raw", "law", "draw", "flaw"]},
    {"æ" => ["sat", "man", "hat", "cat", "fat", "chat", "pat", "last", "add", "vast"]},
    {"e" => ["sketch", "bed", "get", "editor", "pen", "met", "let", "pet", "best", "peck"]},
    {"ə" => ["ago", "banana", "assistant", "problem", "celebrate", "enemy", "duplicate", "president", "family"]},
    {"ɜr" => ["bird", "concern", "hurt", "herd", "alert", "dessert", "skirt", "dirt", "occur", "prefer", "word", "work", "worth", "world", "earth", "learn", "heard", "yearn", "pearl"]},
    {"ər" => ["actor", "doctor", "administrator", "alligator", "ambassador", "concert", "desert", "mother", "teacher", "border"]},
    {"ʊr" => ["tour", "contour", "detour", "parkour", "pure", "allure", "abjure", "adjure", "poor", "spoor", "boorish", "moorhen"]},
    {"ɪ" => ["film", "if", "in", "chill", "started", "wanted", "dances", "buses", "decide", "English"]},
    {"i:" => ["sleep", "sheep", "keep", "beep", "read", "eat", "neat", "beat", "be", "these", "he", "she", "believe", "belief", "field", "chief"]},
    {"ɑr" => ["artist", "car", "Mars", "far", "park", "art", "large", "mark", "aardvark", "afar", "agar", "apartment", "arbitrary", "arcade", "archaic"]},
    {"ɔr" => ["floor", "door", "underfloor", "trapdoor", "dance floor", "score", "chore", "store", "before", "sword", "born", "corn", "horn", "scorn", "thorn"]},
    {"ʊ" => ["put", "sugar", "push", "butcher", "book", "foot", "cook", "hood", "would", "should", "could"]},
    {"u:" => ["too", "bamboo", "spoon", "baboon", "cool", "rude", "flu", "emu", "guru", "impromptu", "blue", "clue", "true", "sue", "glue"]},
    {"aɪ" => ["pint", "islet", "island", "align", "asign", "shine", "ripe", "cite", "fine", "hide", "deny", "try", "apply", "fly", "ally"]},
    {"aʊ" => ["house", "sound", "mouse", "ground", "loud", "how", "towel", "brown", "shower", "allow"]},
    {"eɪ" => ["Asia", "alien", "baker", "decade", "safe", "acclaim", "acquaint", "afraid", "way", "day", "eight", "beige", "weigh", "grey", "they"]},
    {"oʊ" => ["go", "hole", "cold", "bold", "ago", "boat", "boast", "toast", "oat", "low", "show", "arrow", "flow", "borrow", "shoulder", "boulder", "poultice", "poultry", "soul"]},
    {"ɔɪ" => ["appoint", "choice", "moist", "Android", "oil", "destroy", "boy", "toy", "employ", "joy"]},
    {"er" => ["chair", "fair", "lair", "hair", "air", "hare", "share", "square", "blare", "care", "where", "there", "nowhere", "somewhere", "anywhere", "pear", "bear", "wear", "forswear", "swear"]},
    {"ɪr" => ["ear", "beard", "year", "near", "fear", "here", "adhere", "cohere", "sphere", "mere", "beer", "cheer", "leer", "career", "auctioneer", "premier", "cashhier", "chandelier", "cavalier", "bandolier"]},
    {"b" => ["break", "boy", "black", "baby", "rubber", "shabby", "grab", "robe", "tribe"]},
    {"p" => ["parrot", "parcel", "pencil", "happy", "repel", "reply", "trip", "cap", "map"]},
    {"f" => ["fast", "free", "first", "suffer", "affect", "afraid", "leaf", "half", "stiff"]},
    {"v"=> ["view", "vary", "vast", "river", "cover", "divide", "five", "leave", "wave"]},
    {"t" => ["tackle", "tail", "tandem", "technique", "tell", "atomic", "potato", "Italian", "photography", "tattoo", "test", "next", "actor", "left", "halt"]},
    {"d" => ["letter", "better", "water", "data", "put it on", "set it in", "cut it off", "let it out", "affect it all"]},
    {"l" => ["like", "laugh", "less", "large", "long", "low", "learn", "flag", "black", "blog", "feeling", "ceiling", "abolish", "absolute", "reality", "circle", "pull", "milk", "help", "whole", "tall", "pool", "ball", "will", "girl", "puddle", "deal", "detail", "e-mail", "apple"]},
    {"g" => ["give", "guide", "glass", "gaze", "digging", "target", "angle", "cager", "eager", "abrogate", "pig", "plague", "rogue", "backlog", "bedbug"]},
    {"h" => ["heart", "heat", "heard", "hall", "health", "behind", "ahead", "rehearse", "unholy", "unhealthy"]},
    {"k" => ["cave", "class", "kettle", "card", "chemistry", "pocket", "weaker", "market", "alkaline", "awaken", "peak", "break", "dock", "applejack", "earthquake"]}, 
    {"m" => ["man", "make", "mood", "McDonald's", "Macintosh", "permanent", "complaint", "aimless", "abnormal", "accompany", "him", "game", "warm", "comb", "acronym"]},
    {"n" => ["nail", "NASA", "name", "nagging", "nanotechnology", "mint", "accountant", "manage", "abandon", "admonition", "tan", "listen", "down", "town", "alien"]},
    {"ŋ" => ["monk", "link", "finger", "English", "monkey", "sing", "king", "acting", "fang", "wing"]},
    {"s" => ["sink", "said", "seal", "swim", "send", "fussy", "risky", "buses", "erase", "pizza", "mouse", "pass", "force", "books", "lips"]},
    {"ʃ" => ["show", "shy", "shock", "shame", "share", "nation", "issue", "mission", "fashion", "action", "ash", "wash", "leash", "wish", "cash"]},
    {"z" => ["zinc", "zoo", "zeal", "zone", "zero", "loser", "raising", "fuzzy", "lazy", "drowsy", "plays", "knees", "phones", "goes", "moves"]},
    {"ʒ" => ["jabot", "gigue", "genre", "gendarme", "vision", "division", "invasion", "equation", "revision", "mirage", "garage", "beige", "seizure"]},
    {"tʃ" => ["chin", "chock", "chain", "cheer", "chore", "riches", "catching", "watching", "batches", "achieve", "search", "watch", "rich", "beach", "fetch"]},
    {"θ" => ["thrill", "thorough", "therapy", "thesis", "theory", "healthy", "anthology", "author", "authority", "bathroom", "tooth", "math", "breath", "bath", "wealth"]},
    {"ð" => ["they", "their", "than", "that", "those", "brother", "father", "southern", "bather", "bother", "breathe", "bathe", "sheathe", "soothe", "smooth"]},
    {"r" => ["rat", "rare", "radio", "run", "race", "arrive", "arrest", "arrow", "normal", "north", "car", "core", "chair", "doctor", "fir"]},
    {"w" => ["where", "want", "weather", "wolf", "world", "await", "awkward", "liquid", "square", "follower", "how", "allow", "ago", "albino", "impromptu"]},
    {"j" => ["uniform", "union", "young", "yogout", "Europe", "warrior", "labial", "serious", "European", "hyena"]},
    {"dʒ" => ["joke", "judge", "gin", "jeep", "ridges", "badges", "pigeon", "algebra", "advantageous", "surge", "age", "lodge", "damage", "stage"]}
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
