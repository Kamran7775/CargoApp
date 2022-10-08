import 'package:flutter/material.dart';
import 'package:safe_express_cargo_app/core/utils/services/network_util.dart';

class ListImagePreview extends StatefulWidget {
  const ListImagePreview({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<ListImagePreview> createState() => _ListImagePreviewState();
}

class _ListImagePreviewState extends State<ListImagePreview> {
  List<String> imagePathList = [];
  @override
  void initState() {
    getImageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: imagePathList.isNotEmpty
          ? Column(children: [
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: imagePathList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return (imagePathList.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 200,
                                width: 150,
                                child: Image.network(imagePathList[index])),
                          )
                        : const CircularProgressIndicator();
                  },
                ),
              ),
            ])
          : const Center(child: CircularProgressIndicator()),
    );
  }

  getImageList() async {
    var res = await WebService.getDeliveryImages(widget.id);
    if (res != null) {
      for (var i in res) {
        imagePathList.add(i['image']);
      }
      setState(() {});
    }
  }
}
