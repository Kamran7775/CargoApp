import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../core/utils/themes/theme.dart';
import '../../core/widgets/message.dart';
import 'camera_view.dart';

class TakeImageView extends StatefulWidget {
  final ValueSetter<List<String>> callBack;
  const TakeImageView({required this.callBack, Key? key}) : super(key: key);

  @override
  State<TakeImageView> createState() => _TakeImageViewState();
}

class _TakeImageViewState extends State<TakeImageView> {
  List<String> imageList = [];
  bool isBlack = true;
  @override
  void initState() {
    getCameraPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !isBlack
          ? Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Listə Şəkiləri'),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left)),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 9,
                      child: imageList.isEmpty
                          ? const Center(
                              child: Text(
                              'Şəkil çəkin',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Themes.textColor),
                            ))
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 200,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (covariant) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: const Text(
                                          'Silmək istəyirsiz ?',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              message(context, 'Silindi');
                                              setState(() {
                                                imageList.removeAt(index);
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Sil",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Bağla",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  onTap: () {
                                    showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (covariant) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: InteractiveViewer(
                                          child: Image.file(
                                            File(imageList[index]),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Bağla",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(File(imageList[index])),
                                  ),
                                );
                              },
                              itemCount: imageList.length,
                            ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await availableCameras().then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CameraPage(
                                      callBack: (pathList) {
                                        setState(() {
                                          for (var image in pathList) {
                                            imageList.add(image);
                                          }
                                        });
                                      },
                                      cameras: value,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text('Launch Camera'),
                          ),
                          imageList.isEmpty
                              ? Text(
                                  'Okey',
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(1),
                                      fontSize: 18),
                                )
                              : ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green)),
                                  onPressed: () {
                                    widget.callBack(imageList);

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Okey'),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  getCameraPage() async {
    await availableCameras().then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(
            callBack: (pathList) {
              setState(() {
                for (var image in pathList) {
                  imageList.add(image);
                }
              });
            },
            cameras: value,
          ),
        ),
      ).then((value) {
        if (imageList.isNotEmpty) {
          setState(() {
            isBlack = false;
          });
        } else {
          setState(() {
            Navigator.pop(context);
          });
        }
      }),
    );
  }
}
