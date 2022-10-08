class Validations {
//modify regex accordingly
  static String? validateName(String value) {
    if (value.isEmpty) return 'Ad boş qala bilməz.';
//    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
//    if (!nameExp.hasMatch(value))
//      return 'Please enter only alphabetical characters.';
    return null;
  }

  static String? validateSurName(String value) {
    if (value.isEmpty) return 'Soyad boş qala bilməz.';
    return null;
  }

  static String? validateAddress(String value) {
    if (value.isEmpty) return 'Address boş qala bilməz.';
    return null;
  }

  static String? validateUserName(String value) {
    if (value.isEmpty) return 'İstifadəçi adı boş qala bilməz.';
    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Email  düzgün deyil.';
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) return 'Şifrə boş qala bilməz.';
    return null;
  }

  static String? validateDate(String value) {
    if (value.isEmpty) return 'Tarix boş qala bilməz.';
    final RegExp nameExp = RegExp(
        r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$');
    if (!nameExp.hasMatch(value)) return 'Date format should be dd-mm-yyyy.';
    return null;
  }
}
