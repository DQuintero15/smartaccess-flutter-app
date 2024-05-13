import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/screens/home_screen.dart';
import 'package:smartaccess_app/src/screens/navigation_screen.dart';
import 'package:smartaccess_app/src/screens/login_screen.dart';
import 'package:smartaccess_app/src/screens/profile_screen.dart';
import 'package:smartaccess_app/src/screens/scan_screen.dart';
import 'package:smartaccess_app/src/screens/splash_screen.dart';
import 'package:smartaccess_app/src/screens/vehicles_screen.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: AppConstants.supabaseUrl, anonKey: AppConstants.supabaseKey);

  final cameras = await availableCameras();

  runApp(MainApp(
    cameras: cameras,
  ));
}

class MainApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MainApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Access",
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppColor.caribbeanCurrent),
          useMaterial3: true),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/navigation': (context) => NavigationScreen(
              cameras: cameras,
            ),
        '/scan': (context) => ScanScreen(
              cameras: cameras,
            ),
        '/home': (context) => const HomeScreen(),
        '/vehicles': (context) => const VehiclesScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
