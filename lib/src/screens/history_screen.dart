import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/providers/plates_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlatesProvider>(context, listen: false).getPlateData();
    Provider.of<BusinessProvider>(context, listen: false).getBusinessData();
  }

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<BusinessProvider>(context);
    final resultPlate = Provider.of<PlatesProvider>(context);
    
    return Scaffold(
      backgroundColor: AppColor.night,
      body: result.businessData == null || resultPlate.plateData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                                  "assets/images/parking_icon.jpg",
                                ),
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.businessData!.name,
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontFamily: AppConstants.fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  result.businessData!.owner,
                                  style: const TextStyle(
                                    color: AppColor.gray,
                                    fontFamily: AppConstants.fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Tarifa: \$${result.businessData!.coastPerMinute.toString()} COP/min',
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
