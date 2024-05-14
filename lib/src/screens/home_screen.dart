import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/services/business_service.dart';
import 'package:smartaccess_app/src/services/firebase_auth_service.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _businessService = BusinessService();
  final _firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.night,
      body: FutureBuilder(
        future: _firebaseAuthService.currentUser?.getIdToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final token = snapshot.data;
            if (token != null) {
              return FutureBuilder(
                future: _businessService.getBusiness(token),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final businessData = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: const Image(
                                        image: AssetImage(
                                            "assets/images/parking_icon.jpg"),
                                        width: 35,
                                        height: 35,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${businessData?.name}',
                                          style: const TextStyle(
                                            color: AppColor.white,
                                            fontFamily: AppConstants.fontFamily,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          '${businessData?.owner}',
                                          style: const TextStyle(
                                            color: AppColor.gray,
                                            fontFamily: AppConstants.fontFamily,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          'Tarifa: \$${businessData?.coastPerMinute} COP/min',
                                          style: const TextStyle(
                                            color: AppColor.gray,
                                            fontFamily: AppConstants.fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(Icons.notifications,
                                    color: AppColor.white),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const Center(child: Text('Error: No se pudo obtener el token'));
            }
          }
        },
      ),
    );
  }
}
