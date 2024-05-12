import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/screens/splash_screen.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: AppConstants.supabaseUrl, anonKey: AppConstants.supabaseKey);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Access",
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppColor.caribbeanCurrent),
          useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
