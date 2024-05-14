class Validators {
  static bool? isEmail(String? value) {
    if (value == null)  return false;
    
    final email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return email.hasMatch(value);
  }

  static bool? isNumeric(String? value) {
    if (value == null)  return false;
    
    final numeric = RegExp(r'^[0-9]+$');
    return numeric.hasMatch(value);
  }

  static bool? isNotEmpty(String? value) {
    if (value == null)  return false;
    
    return value.isNotEmpty;
  }

  static bool? passwordLength(String? value) {
    if (value == null)  return false;
    
    return value.length >= 6;
  }
}
