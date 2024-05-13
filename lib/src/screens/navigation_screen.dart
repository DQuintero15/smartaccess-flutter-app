import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/screens/history_screen.dart';
import 'package:smartaccess_app/src/screens/home_screen.dart';
import 'package:smartaccess_app/src/screens/profile_screen.dart';
import 'package:smartaccess_app/src/screens/scan_screen.dart';
import 'package:smartaccess_app/src/screens/vehicles_screen.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';

class NavigationScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const NavigationScreen({super.key, required this.cameras});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const VehiclesScreen(),
      ScanScreen(cameras: widget.cameras),
      const HistoryScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        elevation: 0,
        indicatorColor: AppColor.lightGray,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.car_rental),
            label: 'Vehículos',
          ),
          NavigationDestination(
            icon: Icon(Icons.document_scanner_rounded),
            label: 'Escaneo',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
