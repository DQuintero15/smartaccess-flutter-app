import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BusinessProvider>().getBusinessData();
    });

    return Scaffold(
      backgroundColor: AppColor.night,
      body: Consumer<BusinessProvider>(
        builder: (context, value, child) {
          if (value.businessData == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final businessData = value.businessData;
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'Tarifa: \$${context.read<BusinessProvider>().businessData?.coastPerMinute.toString()} COP/min',
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
            );
          }
        },
      ),
    );
  }
}
