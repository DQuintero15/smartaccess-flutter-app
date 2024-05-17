import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/providers/plates_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:intl/intl.dart'; // Asegúrate de tener intl en tus dependencias

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
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: resultPlate.plateData!.length,
                        itemBuilder: (context, index) {
                          final checkIn = resultPlate.plateData![index];
                          final DateTime createdAt =
                              DateTime.parse(checkIn.createdAt).toLocal();
                          final String formattedCreatedAt =
                              DateFormat('yyyy-MM-dd HH:mm:ss', 'es_CO')
                                  .format(createdAt);
                          String? formattedCheckOut;
                          if (checkIn.checkOut != null) {
                            final DateTime checkOut =
                                DateTime.parse(checkIn.checkOut!).toLocal();
                            formattedCheckOut =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(checkOut);
                          }

                          return Card(
                            color: AppColor.night,
                            child: ListTile(
                              title: Text(
                                checkIn.licensePlate.plate,
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontFamily: AppConstants.fontFamily,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Check-in: $formattedCreatedAt',
                                    style: const TextStyle(
                                      color: AppColor.gray,
                                      fontFamily: AppConstants.fontFamily,
                                    ),
                                  ),
                                  if (formattedCheckOut != null)
                                    Text(
                                      'Check-out: $formattedCheckOut',
                                      style: const TextStyle(
                                        color: AppColor.gray,
                                        fontFamily: AppConstants.fontFamily,
                                      ),
                                    ),
                                  Text(
                                    'Minutos estacionado: ${checkIn.minutesParked}',
                                    style: const TextStyle(
                                      color: AppColor.gray,
                                      fontFamily: AppConstants.fontFamily,
                                    ),
                                  ),
                                  Text(
                                    'Monto: \$${checkIn.amount} COP',
                                    style: const TextStyle(
                                      color: AppColor.gray,
                                      fontFamily: AppConstants.fontFamily,
                                    ),
                                  ),
                                  Text(
                                    'Pagado: ${checkIn.paid ? 'Sí' : 'No'}',
                                    style: const TextStyle(
                                      color: AppColor.gray,
                                      fontFamily: AppConstants.fontFamily,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Divider(
                                      color: AppColor.white,
                                      thickness: 1,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
