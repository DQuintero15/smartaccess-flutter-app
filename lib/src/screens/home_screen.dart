import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/services/supabase.service.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? currentUser = SupabaseService().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.night,
      body: Padding(
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
                          image: AssetImage("assets/images/parking_icon.jpg"),
                          width: 35,
                          height: 35,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${currentUser?.userMetadata?["first_name"]} ${currentUser?.userMetadata?["last_name"]}',
                            style: const TextStyle(
                              color: AppColor.white,
                              fontFamily: AppConstants.fontFamily,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            '${currentUser?.userMetadata?["business_name"]}',
                            style: const TextStyle(
                              color: AppColor.gray,
                              fontFamily: AppConstants.fontFamily,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'Tarifa: \$${currentUser?.userMetadata?["parking_fee_per_minute"]} COP/min',
                            style: const TextStyle(
                              color: AppColor.gray,
                              fontFamily: AppConstants.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications, color: AppColor.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}