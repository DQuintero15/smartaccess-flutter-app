import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartaccess_app/src/services/supabase.service.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    cameras = widget.cameras;
    initializeCamera();
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

                final url = Uri.parse(
                    'https://api.cloudinary.com/v1_1/${AppConstants.cloudName}/image/upload');

                final request = http.MultipartRequest('POST', url)
                  ..fields['upload_preset'] = AppConstants.uploadPreset
                  ..files.add(
                      await http.MultipartFile.fromPath('file', image.path));

                final response = await request.send();

                setState(() {
                  isUploadingToCloudinary = false;
                });

                if (response.statusCode == 200) {
                  final responseString = await response.stream.bytesToString();
                  Fluttertoast.showToast(
                      msg: "Imagen Subida Exitosamente",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  final secureUrl =
                      responseString.split('secure_url":"')[1].split('"')[0];

                  final proccessingRequest = Uri.parse(
                    '${AppConstants.apiBaseUrl}hook',
                  );

                  setState(() {
                    isProcessing = true;
                  });

                  final currentSession =await SupabaseService().getCurrentSession();
                  final accessToken = currentSession?.accessToken;

                  final processingResponse = await http.post(proccessingRequest,
                      headers: {
                        "Authorization": "Bearer $accessToken",
                        "Content-Type": "application/json"
                      },
                      body: jsonEncode({
                        'image_url': secureUrl,
                      }));

                  setState(() {
                    isProcessing = false;
                  });

                  if (processingResponse.statusCode == 200) {
                    Fluttertoast.showToast(
                        msg: "Imagen Procesada Exitosamente",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Error al Procesar Imagen",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }

                  final proccessingResponseString = processingResponse.body;
                  final resultDecoded = jsonDecode(proccessingResponseString);
                  
                  final result = resultDecoded['result'];


                  if (result != null) {
                    Fluttertoast.showToast(
                        msg: "Placa $result Detectada. Total a Pagar: \$5300 COP",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Error al procesar Imagen",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
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
