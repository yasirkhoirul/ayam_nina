class MyValidators {
  const MyValidators._();

  static String? notNull(String? input) {
    if (input == null || input.isEmpty) {
      return "Input tidak boleh kosong";
    }
    return null;
  }

  static String? notZeroNumber(int? input) {
    if (input == null || input <= 0) {
      return "Input tidak boleh kosong atau nol";
    }
    return null;
  }
}
