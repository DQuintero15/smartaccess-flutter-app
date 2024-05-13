class AppConstants {
  static const String appName = 'SmartAccess';
  static const String appVersion = '1.0.0';
  static const fontFamily = 'Satoshi';
  static const String smallWhiteLogo = 'assets/images/smartaccess_white_small_logo.png';
  static const String splashAnimation = 'assets/lottie/animation.json';
  static const String apiBaseUrl =  String.fromEnvironment('API_BASE_URL');
  static const  supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const  supabaseKey = String.fromEnvironment('SUPABASE_KEY');
  static const cloudName = String.fromEnvironment('CLOUD_NAME');
  static const uploadPreset = String.fromEnvironment('UPLOAD_PRESET');
}