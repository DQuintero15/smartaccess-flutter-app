import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BusinessProvider>(context, listen: false).getBusinessData();
  }
  @override
  Widget build(BuildContext context) {
    final result = Provider.of<BusinessProvider>(context);
    return  Scaffold(
      backgroundColor: AppColor.night,
      body: result.nonCheckInPlates == null
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
                              child:  const Image(
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
                                  result.nonCheckInPlates!.name,
                                  style:  const TextStyle(
                                    color: AppColor.white,
                                    fontFamily: AppConstants.fontFamily,
                                  ),
                                ),
                                 const SizedBox(height: 1),
                                Text(
                                  result.nonCheckInPlates!.owner,
                                  style:  const TextStyle(
                                    color: AppColor.gray,
                                    fontFamily: AppConstants.fontFamily,
                                  ),
                                ),
                                 const SizedBox(height: 1),
                                Text(
                                  'Tarifa: \$${result.nonCheckInPlates!.coastPerMinute.toString()} COP/min',
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