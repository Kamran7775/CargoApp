import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final ValueSetter<List<String>> callBack;
  const CameraPage({this.cameras, required this.callBack, Key? key})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with TickerProviderStateMixin {
  late AnimationController controlAnimated;
  late CameraController controller;
  XFile? pictureFile;
  List<String> imagePathList = [];
  bool cameras = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    controlAnimated =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized || isPaused) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: SizedBox(
                    width: double.infinity, child: CameraPreview(controller)),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          imagePathList.length.toString(),
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            isPaused = true;
                          });
                          Timer(const Duration(milliseconds: 10), () async {
                            pictureFile = await controller.takePicture();
                            if (pictureFile != null) {
                              setPref(pictureFile!.path);

                              setState(() {
                                imagePathList.add(pictureFile!.path);
                                isPaused = false;
                              });
                            }
                          });
                        },
                        child: const Icon(
                          Icons.camera,
                          color: Colors.blue,
                          size: 60,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          widget.callBack(imagePathList);

                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // if (pictureFile != null) Image.file(File(pictureFile!.path))
              // Image.f(
              //   pictureFile!.path,
              //   height: 200,
              // )
              //Android/iOS
              // Image.file(File(pictureFile!.path)))
            ],
          ),
        ),
      ),
    );
  }

  setPref(path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image1', path);
  }
}
