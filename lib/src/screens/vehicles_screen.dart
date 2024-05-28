import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/business_provider.dart';
import 'package:smartaccess_app/src/providers/plates_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:intl/intl.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlatesProvider>(context, listen: false).getNonCheckInPlates();
    Provider.of<BusinessProvider>(context, listen: false).getBusinessData();
  }

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<BusinessProvider>(context);
    final resultPlate = Provider.of<PlatesProvider>(context);
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'es_CO', name: "COP");

    return Scaffold(
      backgroundColor: AppColor.night,
      body: result.nonCheckInPlates == null ||
              resultPlate.nonCheckInPlates == null
          ? const Center(child: CircularProgressIndicator())
          : resultPlate.nonCheckInPlates!.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        color: AppColor.white,
                        size: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No hay registros',
                        style: TextStyle(
                          color: AppColor.white,
                          fontFamily: AppConstants.fontFamily,
                        ),
                      ),
                    ],
                  ),
                )
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
                            const Icon(Icons.notifications,
                                color: AppColor.white),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: resultPlate.nonCheckInPlates!.length,
                            itemBuilder: (context, index) {
                              final checkIn =
                                  resultPlate.nonCheckInPlates![index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        'Monto: ${formatCurrency.format(checkIn.amount)} COP',
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
