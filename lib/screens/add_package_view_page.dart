import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safe_express_cargo_app/screens/base_view_page.dart';
import '../core/image/image.dart';
import '../core/utils/services/network_util.dart';
import '../core/utils/services/size_config.dart';
import '../core/utils/themes/theme.dart';
import '../model/package_list_model.dart';
import 'add2_view_page.dart';
import 'camera/take_image_view.dart';
import 'list_image_preview.dart';

class AddPackageViewPage extends StatefulWidget {
  const AddPackageViewPage({required this.id, Key? key}) : super(key: key);
  final int id;
  @override
  State<AddPackageViewPage> createState() => _AddPackageViewPageState();
}

class _AddPackageViewPageState extends State<AddPackageViewPage> {
  List<List<String>> imageList = [];
  Map<String, bool> isFilled = {};
  String _text = '';
  String cargoTitle = '';
  String currierName = '';
  int packageCount = 0;
  int fullPackageCount = 1;
  String createdTime = '';
  @override
  void initState() {
    _text = 'Sevkiyat: ' + widget.id.toString();
    deliveryDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_text),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (contex) => const BaseViewPage()));
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
      ),
      body: Padding(
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
                        Text(cargoTitle,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Themes.textColor)),
                      ],
                    ),
                    SizedBox(height: AppSize.calculateHeight(context, 5)),
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
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text('Tarix: ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Themes.textColor)),
                        Text(createdTime,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Themes.textColor)),
                      ],
                    ),
                    SizedBox(height: AppSize.calculateHeight(context, 5)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text('Bağlama Sayı: ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Themes.textColor)),
                        packageCount == fullPackageCount
                            ? Text(packageCount.toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green))
                            : Text(fullPackageCount.toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffFEAE35)))
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSize.calculateHeight(context, 18)),
            Container(
              width: AppSize.calculateWidth(context, 335),
              height: AppSize.calculateHeight(context, 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xff039BE5)),
              child: TextButton(
                onPressed: () {
                  getEmptyElement();
                },
                child: const Center(
                    child: Text(
                  'Şəkilləri Əlavə Et',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
              ),
            ),
            SizedBox(height: AppSize.calculateHeight(context, 24)),
            Container(
              width: AppSize.calculateWidth(context, 335),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffdadada), width: 1),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    right: AppSize.calculateWidth(context, 18),
                    left: AppSize.calculateWidth(context, 18),
                    top: AppSize.calculateHeight(context, 14),
                    bottom: AppSize.calculateHeight(context, 12)),
                child: SizedBox(
                  height: AppSize.calculateHeight(context, 270),
                  width: double.infinity,
                  child: FutureBuilder<List<PackageModel>>(
                    future: WebService.getPackageList(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        List<PackageModel>? data = snapshot.data;

                        return getPackageList(data);
                      }
                      return const Center(
                        child: SpinKitPianoWave(
                          size: 50,
                          color: Themes.sliderColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.calculateHeight(context, 16)),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Listin Şəkli: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Themes.textColor),
                ),
                SizedBox(width: AppSize.calculateWidth(context, 3)),
                InkWell(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListImagePreview(id: widget.id)))
                          .then(onGoBack);
                    },
                    child: Image.asset(AppImage.attachment)),
              ],
            )
          ],
        ),
      ),
    ));
  }

  deliveryDetail() async {
    var response = await WebService.getDeliveryDetail(widget.id);
    if (response != false) {
      setState(() {
        cargoTitle = response["cargo_company"]["title"];
        currierName = response["courier"]["first_name"] +
            " " +
            response["courier"]["last_name"];
        packageCount = response["package_count"];

        createdTime = response["created_at"];
        fullPackageCount = response["package_count_which_has_image"];
      });
    } else {}
  }

  getPackageList(data) {
    return SizedBox(
      child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisExtent: 40,
          ),
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) {
            isFilled[data[index].id.toString()] = data[index].imagesFilled;
            return SizedBox(
              height: 60,
              width: 60,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Add2ViewPage(id: data[index].id.toString())))
                      .then(onGoBack);
                },
                child: data[index].imagesFilled
                    ? Image.asset(AppImage.packageActiv)
                    : Image.asset(AppImage.packagePassif),
              ),
            );
          }),
    );
  }

  getEmptyElement() {
    for (var value in isFilled.keys) {
      if (isFilled[value] == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TakeImageView(callBack: (imagePathList) {
                      getPackageListt(value, imagePathList);
                      if (imageList.length == 2) {
                        isFilled[value] = true;
                      }
                    }))).then(onGoBack);
        break;
      }
    }
  }

  getPackageListt(value, imagePathList) async {
    var response = await WebService.updatePackageList(
        widget.id, int.parse(value), imagePathList);
    if (response) {
      await WebService.getPackageList(widget.id);

      setState(() {});
    } else {}
  }

  onGoBack(dynamic value) async {
    await WebService.getPackageList(widget.id);
    deliveryDetail();
    setState(() {});
  }
}
