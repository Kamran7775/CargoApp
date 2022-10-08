import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../core/utils/services/network_util.dart';
import '../core/utils/services/size_config.dart';
import '../core/utils/themes/theme.dart';
import '../core/widgets/button.dart';
import '../core/widgets/message.dart';
import '../model/cargo_list_response_model.dart';
import '../model/couriers_list_response_model.dart';
import 'add_package_view_page.dart';
import 'camera/take_image_view.dart';

class AddDeliveryViewPage extends StatefulWidget {
  const AddDeliveryViewPage({Key? key}) : super(key: key);

  @override
  State<AddDeliveryViewPage> createState() => _AddDeliveryViewPageState();
}

class _AddDeliveryViewPageState extends State<AddDeliveryViewPage> {
  TextEditingController packageCountEditController = TextEditingController();
  DateTime _dataTime = DateTime.now();
  final String _text = 'Əlavə et';
  final String _text1 = 'Ləğv et';
  final String _text2 = 'Təslimatı Əlavə Et';
  CargoListResponseModel? cargoValue;
  CouriersListResponseModel? couriersValue;
  List<CouriersListResponseModel> couriersList = [];
  List<CargoListResponseModel> companiesList = [];
  List<String>? images = [];
  bool _isloading = false;

  @override
  void initState() {
    getCargoCompanies();
    super.initState();
  }

  DropdownMenuItem<String> menuItem(String item) => DropdownMenuItem(
        value: item,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            item,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Themes.textColor),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_text),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: AppSize.calculateWidth(context, 28),
                right: AppSize.calculateWidth(context, 20)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: AppSize.calculateHeight(context, 35)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _text2,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Themes.textColor,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(height: AppSize.calculateHeight(context, 30)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Themes.greySolid, width: 1),
                        color: const Color(0xfff1f1f1)),
                    height: AppSize.calculateHeight(context, 50),
                    width: AppSize.calculateWidth(context, 319),
                    child: DropdownButton<CargoListResponseModel>(
                        isExpanded: true,
                        hint: Padding(
                          padding: EdgeInsets.only(
                              left: AppSize.calculateHeight(context, 10)),
                          child: const Text(
                            'Kargo Firmasi',
                            style: TextStyle(
                                fontSize: 14, color: Themes.textColor),
                          ),
                        ),
                        value: cargoValue,
                        items: companiesList
                            .map<DropdownMenuItem<CargoListResponseModel>>(
                                (CargoListResponseModel value) {
                          return DropdownMenuItem<CargoListResponseModel>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppSize.calculateHeight(context, 10)),
                              child: Text(
                                value.title.toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Themes.textColor),
                              ),
                            ),
                          );
                        }).toList(),
                        underline:
                            DropdownButtonHideUnderline(child: Container()),
                        onChanged: (value) {
                          setState(() {
                            cargoValue = value;
                            getCouriesr();
                          });
                        }),
                  ),
                  SizedBox(height: AppSize.calculateHeight(context, 15)),
                  cargoValue != null
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Themes.greySolid, width: 1),
                              color: const Color(0xfff1f1f1)),
                          height: AppSize.calculateHeight(context, 50),
                          width: AppSize.calculateWidth(context, 319),
                          child: DropdownButton<CouriersListResponseModel>(
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(
                                    left: AppSize.calculateHeight(context, 10)),
                                child: const Text(
                                  'Kuryer',
                                  style: TextStyle(
                                      fontSize: 14, color: Themes.textColor),
                                ),
                              ),
                              value: couriersValue,
                              items: couriersList.map<
                                      DropdownMenuItem<
                                          CouriersListResponseModel>>(
                                  (CouriersListResponseModel value) {
                                return DropdownMenuItem<
                                    CouriersListResponseModel>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: AppSize.calculateHeight(
                                            context, 10)),
                                    child: Text(
                                      value.firstName.toString() +
                                          " " +
                                          value.lastName.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Themes.textColor),
                                    ),
                                  ),
                                );
                              }).toList(),
                              underline: DropdownButtonHideUnderline(
                                  child: Container()),
                              onChanged: (value) {
                                setState(() {
                                  couriersValue = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  SizedBox(height: AppSize.calculateHeight(context, 15)),
                  SizedBox(
                    height: AppSize.calculateHeight(context, 50),
                    width: AppSize.calculateWidth(context, 319),
                    child: CustomTextFieldWidget(
                        textInputType: TextInputType.number,
                        validate: false,
                        hintText: 'Bağlama Sayı',
                        textEditingController: packageCountEditController),
                  ),
                  SizedBox(height: AppSize.calculateHeight(context, 15)),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        side: const BorderSide(color: Themes.buttonColor),
                      ),
                      onPressed: () async {},
                      child: Text(
                        DateFormat('dd-MM-yyyy - KK:mm').format(_dataTime),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.calculateHeight(context, 15)),
                  Center(
                    child: Stack(
                      children: [
                        CustomBotton(
                          buttonText: 'Listin şəkillərini yüklə',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TakeImageView(
                                          callBack: ((values) {
                                            setState(() {
                                              images = values;
                                            });
                                          }),
                                        )));
                          },
                          buttonColor: Themes.scaffoldBackgroundColor,
                          buttonBorderSideColor: Themes.elevedButColor,
                          buttonTextColor: Themes.elevedButColor,
                        ),
                        images!.isEmpty
                            ? const SizedBox()
                            : Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.green,
                                    child: Text(
                                      images!.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )))
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.calculateHeight(context, 25)),
                  // InkWell(
                  //   onTap: () {},
                  //   child: SizedBox(
                  //     height: AppSize.calculateHeight(context, 25),
                  //     width: AppSize.calculateWidth(context, 25),
                  //     child: Image.asset(AppImage.attachment),
                  //   ),
                  // ),
                  SizedBox(height: AppSize.calculateHeight(context, 100)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _isloading == false
                          ? Container(
                              child: TextButton(
                                onPressed: () {
                                  packageCountEditController.text.isEmpty
                                      ? _isloading = false
                                      : createDelivery();
                                },
                                child: Center(
                                  child: Text(
                                    _text,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Themes.elevedTextColor),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0xff1E88E5)),
                              width: AppSize.calculateWidth(context, 155),
                              height: AppSize.calculateHeight(context, 55),
                            )
                          : const SpinKitFadingCircle(
                              color: Themes.primaryColor,
                            ),
                      SizedBox(width: AppSize.calculateWidth(context, 9)),
                      Container(
                        child: TextButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              _text1,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1E88E5)),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff1E88E5), width: 1),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        width: AppSize.calculateWidth(context, 155),
                        height: AppSize.calculateHeight(context, 55),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<DateTime> updateTime(BuildContext context, DateTime _time) async {
    return _dataTime = await showDatePicker(
            context: context,
            initialDate: _time,
            firstDate: _time.subtract(const Duration(days: 365)),
            lastDate: _time) ??
        _dataTime;
  }

  createDelivery() async {
    setState(() {
      _isloading = true;
    });
    var response = await WebService.postDelivery(cargoValue!.id.toString(),
        couriersValue!.id.toString(), packageCountEditController.text, images!);
    if (response != false) {
      setState(() {
        _isloading = false;
      });
      message(context, 'Uğurlu');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddPackageViewPage(id: response)));
    } else {
      setState(() {
        _isloading = false;
      });
      showTopSnackBar(
          context, const CustomSnackBar.error(message: 'Xəta baş verdi'));
    }
  }

  getCargoCompanies() async {
    companiesList = [];

    final response = await WebService.getCargoCompaniesList();
    setState(() {
      companiesList = response;
    });
  }

  getCouriesr() async {
    couriersList = [];
    final response = await WebService.getCouriersList(cargoValue!.id);
    setState(() {
      couriersList = response;
    });
  }
}
