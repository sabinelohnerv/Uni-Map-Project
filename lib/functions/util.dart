bool isValidEmail(String email) {
  final RegExp regex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@(?:univalle\.edu|est\.univalle\.edu)$",
    caseSensitive: false,
  );
  return regex.hasMatch(email);
}

bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#\$&*~]'))) return false;

    return true;
}