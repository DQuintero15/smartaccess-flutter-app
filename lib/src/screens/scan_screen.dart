import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartaccess_app/src/providers/clodinary_provider.dart';
import 'package:smartaccess_app/src/providers/detection_provider.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';

class ScanScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ScanScreen({super.key, required this.cameras});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isCameraReady = false;
  int direction = 0;
  bool isFlashOn = false;
  bool isUploadingToCloudinary = false;
  bool isProcessing = false;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'es_CO', name: "COP");


  @override
  void initState() {
    super.initState();
    cameras = widget.cameras;
    initializeCamera();
    Provider.of<CloudinaryProvider>(context, listen: false).secureUrl;
    Provider.of<DetectionProvider>(context, listen: false).result;
  }

  void initializeCamera() {
    controller = CameraController(cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraReady = true;
      });
    }).catchError((e) {
      // print('Error: $e');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cloudinaryProvider = Provider.of<CloudinaryProvider>(context);
    final detectionProvider = Provider.of<DetectionProvider>(context);

    if (!isCameraReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: CameraPreview(controller)),
        if (isUploadingToCloudinary)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),

        if (isProcessing)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),

        // Take Picture Button
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            backgroundColor: AppColor.white,
            onPressed: () async {
              // Take Picture
              try {
                final image = await controller.takePicture();

                setState(() {
                  isUploadingToCloudinary = true;
                });

                await cloudinaryProvider.uploadImage(image.path);

                setState(() {
                  isUploadingToCloudinary = false;
                  isProcessing = true;
                });

                if (cloudinaryProvider.secureUrl != null) {
                  await detectionProvider
                      .getDetection(cloudinaryProvider.secureUrl!);
                }

                setState(() {
                  isProcessing = false;
                });

                /**
                 * class Detection {
                    final String plateNumber;
                    final Double totalToPay;
                 */

                if (detectionProvider.result != null && context.mounted) {
                  AlertDialog(
                    title: const Text('Resultado de la Detección'),
                    content: Column(
                      children: [
                        Text(
                            'Placa: ${detectionProvider.result!.plateNumber}'),
                        Text(
                            'Total a Pagar: ${formatCurrency.format(detectionProvider.result!.totalToPay)}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                }

              } catch (e) {
                Fluttertoast.showToast(
                    msg: "Error al Tomar Foto",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              detectionProvider.clearDetection();
              cloudinaryProvider.clearSecureUrl();

              return;

            },
            child: const Icon(Icons.camera, color: AppColor.caribbeanCurrent),
          ),
        ),

        // Flash Button
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: AppColor.white,
            onPressed: () {
              if (!isFlashOn) {
                controller.setFlashMode(FlashMode.torch);
              } else {
                controller.setFlashMode(FlashMode.off);
              }
              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
            child: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: AppColor.caribbeanCurrent,
            ),
          ),
        ),
      ],
    ));
  }
}
