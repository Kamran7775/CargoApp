import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/image/image.dart';
import '../core/utils/services/network_util.dart';
import '../core/utils/services/size_config.dart';
import '../core/utils/themes/theme.dart';
import '../model/get_deliveries_response_model.dart';
import 'add_package_view_page.dart';

class CalendarViewPage extends StatefulWidget {
  const CalendarViewPage({Key? key}) : super(key: key);

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  final String _appText = 'Ana Səhifə';
  int totalPackageCount = 0;

  DateTime _dataTime = DateTime.now();
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  calendar() async {
    var _time = DateTime.now();
    await updateTime(context, _time);

    setState(() {});
  }

  updateTime(BuildContext context, DateTime _time) async {
    _dataTime = await showDatePicker(
            context: context,
            initialDate: _time,
            firstDate: _time.subtract(const Duration(days: 365)),
            lastDate: _time) ??
        _dataTime;
    setState(() {
      selectedDate = DateFormat('yyyy-MM-dd').format(_dataTime);
      getTotalCount();
    });
  }

  @override
  void initState() {
    getTotalCount();
    getTotalPackageCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_appText),
          actions: [
            IconButton(
                onPressed: () {
                  calendar();
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: AppSize.calculateWidth(context, 20),
                right: AppSize.calculateWidth(context, 20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.calculateHeight(context, 19),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                      height: AppSize.calculateHeight(context, 5),
                      color: Colors.black,
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppSize.calculateWidth(context, 18),
                        right: AppSize.calculateWidth(context, 18),
                      ),
                      child: Text(
                        selectedDate,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      height: AppSize.calculateHeight(context, 5),
                      color: Colors.black,
                    )),
                  ],
                ),
                SizedBox(height: AppSize.calculateHeight(context, 19)),
                FutureBuilder<List<GetDeliveriesResponseModel>>(
                  future: WebService.getDelivers(selectedDate),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      List<GetDeliveriesResponseModel>? data = snapshot.data;

                      return getDeliveriesList(data);
                    }
                    return const Center(
                      child: SpinKitPianoWave(
                        size: 50,
                        color: Themes.sliderColor,
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSize.calculateHeight(context, 10)),
                Text(
                  'Toplam Bağlama: $totalPackageCount',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Montserrat'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox getDeliveriesList(data) {
    return SizedBox(
      height: AppSize.calculateHeight(context, 500),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddPackageViewPage(id: data[index].id)));
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: AppSize.calculateHeight(context, 11)),
                child: Container(
                  width: AppSize.calculateWidth(context, 335),
                  height: AppSize.calculateHeight(context, 45),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: const Color(0xffd9d9d9), width: 1)),
                  child: Row(
                    children: [
                      SizedBox(width: AppSize.calculateWidth(context, 15)),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              data[index].id.toString() + ' - ',
                              style: _textStyle(),
                            ),
                            SizedBox(width: AppSize.calculateWidth(context, 5)),
                            Text(
                              data[index].cargoCompany.title,
                              style: _textStyle(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Container(
                              width: AppSize.calculateWidth(context, 35),
                              height: AppSize.calculateHeight(context, 25),
                              color: Themes.primaryColor,
                              child: Center(
                                child: Text(data[index].packageCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                                width: AppSize.calculateWidth(context, 16)),
                            InkWell(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (covariant) => AlertDialog(
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(20.0))),
                                //     content: InteractiveViewer(
                                //       child: Image.network(
                                //         data[index].images.image.toString(),
                                //         fit: BoxFit.contain,
                                //       ),
                                //     ),
                                //     actions: <Widget>[
                                //       TextButton(
                                //         onPressed: () {
                                //           Navigator.pop(context);
                                //         },
                                //         child: Text(
                                //           "Bağla",
                                //           style: TextStyle(
                                //               color: Colors.black,
                                //               fontSize: 18),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // );
                              },
                              child: SizedBox(
                                  width: AppSize.calculateWidth(context, 25),
                                  height: AppSize.calculateHeight(context, 25),
                                  child: Image.asset(AppImage.attachment)),
                            ),
                            SizedBox(width: AppSize.calculateWidth(context, 9)),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (covariant) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    content: Text(
                                      data[index].courier.phoneNumber,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    title: Text(
                                      data[index].courier.firstName +
                                          ' ' +
                                          data[index].courier.lastName,
                                      style: const TextStyle(fontSize: 18),
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
                              child: SizedBox(
                                  width: AppSize.calculateWidth(context, 25),
                                  height: AppSize.calculateHeight(context, 25),
                                  child: Image.asset(AppImage.man)),
                            ),
                            SizedBox(
                                width: AppSize.calculateWidth(context, 11)),
                            SizedBox(
                                width: AppSize.calculateWidth(context, 25),
                                height: AppSize.calculateHeight(context, 25),
                                child: data[index].imagesField == true
                                    ? Image.asset(AppImage.check)
                                    : const Icon(
                                        Icons.mood_bad,
                                        color: Colors.red,
                                      ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // calculateCountPackage(
  //   int count,
  // ) {
  //   setState(() {
  //     totalPackageCount += count;
  //   });
  // }

  getTotalCount() async {
    var response2 = await WebService.getTotalPackageCount(selectedDate);
    if (response2 != null) {
      setState(() {
        totalPackageCount = response2;
      });
    } else {}
  }

  TextStyle _textStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Themes.listTextColor);
  }

  getTotalPackageCount() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      totalPackageCount = prefs.getInt('total_package') as int;
    });
  }
}
