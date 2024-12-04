





class TranslatedWords {

  static final Map<String, Map<String, String>> translations = {
    "start listen music": {
      "en": "start listen music",
      "pt": "ouvir músicas",
      "th": "เริ่มฟังเพลง", // Tradução em tailandês
    },
    "login": {
      "en": "Login",
      "pt": "Acessar",
      "th": "เข้าสู่ระบบ", // Tradução em tailandês
    },
  };

  // Método para obter a tradução com base no idioma atual
  static String get(String key, String currentLanguage) {
    return translations[key]?[currentLanguage] ?? key; // Fallback para a chave original
  }
}


