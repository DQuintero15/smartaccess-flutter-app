import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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

  @override
  void initState() {
    super.initState();
    cameras = widget.cameras;
    initializeCamera();
  }

  void initializeCamera() {
    controller = CameraController(
        cameras[direction], ResolutionPreset.medium,
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

        // Take Picture Button
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            backgroundColor: AppColor.white,
            onPressed: () {
              // Take Picture
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
              if (controller.value.flashMode == FlashMode.off) {
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
