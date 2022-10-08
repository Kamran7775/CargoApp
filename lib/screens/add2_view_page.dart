import 'package:flutter/material.dart';

import '../core/utils/services/network_util.dart';
import '../core/utils/services/size_config.dart';
import '../core/utils/themes/theme.dart';

class Add2ViewPage extends StatefulWidget {
  const Add2ViewPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<Add2ViewPage> createState() => _Add2ViewPageState();
}

class _Add2ViewPageState extends State<Add2ViewPage> {
  String _text = 'Package: ';
  int deliveryId = 0;
  String karqoCompanyName = '';
  String currierName = '';
  String createAt = '';

  List<String> imagePathList = [];
  @override
  void initState() {
    packageDetail();
    _text = _text + widget.id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_text),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
      ),
      body: (imagePathList.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: AppSize.calculateWidth(context, 20),
                    right: AppSize.calculateWidth(context, 20)),
                child: Column(
                  children: [
                    SizedBox(height: AppSize.calculateHeight(context, 22)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text('Kargo: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Themes.textColor)),
                                Text(karqoCompanyName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Themes.textColor)),
                              ],
                            ),
                            SizedBox(
                                height: AppSize.calculateHeight(context, 5)),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text('Kuryer: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Themes.textColor)),
                                Text(currierName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Themes.textColor)),
                              ],
                            ),
                            SizedBox(
                                height: AppSize.calculateHeight(context, 5)),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text('Tarix T:   ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Themes.textColor)),
                                Text(createAt,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Themes.textColor)),
                              ],
                            ),
                            SizedBox(
                                height: AppSize.calculateHeight(context, 5)),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text('Tarix SH: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Themes.textColor)),
                                Text(createAt,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Themes.textColor)),
                              ],
                            ),
                            SizedBox(
                                height: AppSize.calculateHeight(context, 5)),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: AppSize.calculateHeight(context, 22)),
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(8),
                    //             border: Border.all(
                    //                 color: const Color(0xffdedede), width: 1)),
                    //         height: AppSize.calculateHeight(context, 163),
                    //         width: AppSize.calculateWidth(context, 160),
                    //       ),
                    //     ),
                    //     SizedBox(width: AppSize.calculateWidth(context, 10)),
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(8),
                    //             border: Border.all(
                    //                 color: const Color(0xffdedede), width: 1)),
                    //         height: AppSize.calculateHeight(context, 163),
                    //         width: AppSize.calculateWidth(context, 160),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: AppSize.calculateHeight(context, 25)),
                    // for (int i = 0; i < imagePathList.length; i++)
                    //   SizedBox(
                    //       height: 300,
                    //       width: 150,
                    //       child: Image.network(
                    //           'https://safex.web.tr${imagePathList[i]}')),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: imagePathList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return (imagePathList.isNotEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: Image.network(
                                          'https://safex.web.tr' +
                                              imagePathList[index])),
                                )
                              : const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Container(
                      width: AppSize.calculateWidth(context, 335),
                      height: AppSize.calculateHeight(context, 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xffD71149)),
                      child: TextButton(
                        onPressed: () {
                          deleteImages();
                        },
                        child: const Center(
                            child: Text(
                          'Şəkilləri Sil',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  packageDetail() async {
    var response = await WebService.getPackageDetails(widget.id);
    if (response != false) {
      setState(() {
        karqoCompanyName = response["cargo_company"]["title"];
        deliveryId = response["delivery"];
        createAt = response["created_at"];
        currierName = response["courier"]["first_name"] +
            " " +
            response["courier"]["last_name"];
        for (int i = 0; i < response["images"].length; i++) {
          imagePathList.add(response["images"][i]['image']);
        }
      });
    } else {}
  }

  deleteImages() async {
    var response = await WebService.deletePackage(
        deliveryId, int.parse(widget.id), imagePathList);

    if (response != false) {
      Navigator.pop(context);
      setState(() {});
    } else {}
  }
}
