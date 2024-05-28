import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/providers/plates_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BusinessProvider>(context, listen: false).getBusinessData();
  }

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<BusinessProvider>(context);

    return Scaffold(
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
                                  result.nonCheckInPlates!.name,
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontFamily: AppConstants.fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  result.nonCheckInPlates!.owner,
                                  style: const TextStyle(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        backgroundColor: AppColor.white,
        child: const Icon(Icons.add, color: AppColor.night),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        String plateNumber = '';

        return AlertDialog(
          title: const Text('Registrar Placa'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Número de Placa'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el número de la placa';
                }
                return null;
              },
              onSaved: (value) {
                plateNumber = value!;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  await Provider.of<PlatesProvider>(context, listen: false)
                      .createPlate(plateNumber);

                  if (context.mounted) Navigator.of(context).pop();

                  plateNumber = '';
                }
              },
              child: const Text('Registrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
