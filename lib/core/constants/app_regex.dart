class AppRegex {
  static final RegExp name = RegExp(r"[A-Za-zА-Яа-яІіЇїЄє]{2,}$");
  static final RegExp nonDigits = RegExp(r'\D');
  static final RegExp upperCase = RegExp(r'[A-Z]');
  static final RegExp nums = RegExp(r'\d');
  static final RegExp passwordDigit = RegExp(r'[0-9]');
  static final RegExp passwordSpecialChar = RegExp(
    r'[!@#\$%\^&\*\(\)_\+\-=\{\}\[\]:;"\<>,\.\?\/\\]',
  );
}
