import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/api/firebase_api.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/providers/clodinary_provider.dart';
import 'package:smartaccess_app/src/providers/detection_provider.dart';
import 'package:smartaccess_app/src/screens/home_screen.dart';
import 'package:smartaccess_app/src/screens/navigation_screen.dart';
import 'package:smartaccess_app/src/screens/login_screen.dart';
import 'package:smartaccess_app/src/screens/profile_screen.dart';
import 'package:smartaccess_app/src/screens/register_screen.dart';
import 'package:smartaccess_app/src/screens/scan_screen.dart';
import 'package:smartaccess_app/src/screens/splash_screen.dart';
import 'package:smartaccess_app/src/screens/vehicles_screen.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CloudinaryObject.fromCloudName(cloudName: AppConstants.cloudName);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseApi().init();

  final cameras = await availableCameras();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BusinessProvider()),
        ChangeNotifierProvider(create: (context) => CloudinaryProvider()),
        ChangeNotifierProvider(create: (context) => DetectionProvider()),
      ],
      child: MainApp(
        cameras: cameras,
      )));
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
        '/register': (context) => RegisterScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
