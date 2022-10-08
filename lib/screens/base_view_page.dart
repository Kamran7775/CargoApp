import 'package:flutter/material.dart';

import '../core/utils/themes/theme.dart';
import 'add_delivery_view_page.dart';
import 'calendart_view_page.dart';
import 'home_view_page.dart';

class BaseViewPage extends StatefulWidget {
  const BaseViewPage({Key? key}) : super(key: key);

  @override
  State<BaseViewPage> createState() => _BaseViewPageState();
}

class _BaseViewPageState extends State<BaseViewPage> {
  int centerIndex = 2;
  int _navigatorIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeViewPage(),
    AddDeliveryViewPage(),
    CalendarViewPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _navigatorIndex =1;
            });
          },
          child: const Icon(
            Icons.add,
            size: 48,
          ),
        ),
        body: _widgetOptions.elementAt(_navigatorIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Themes.primaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 9,
          unselectedFontSize: 9,
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  size: 32,
                ),
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
                label: 'Ana sayfa'),
            BottomNavigationBarItem(icon: SizedBox(), label: ''),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.calendar_month,
                size: 32,
              ),
              icon: Icon(
                Icons.calendar_month,
                size: 32,
              ),
              label: 'Kalendar',
            ),
          ],
          currentIndex: _navigatorIndex,
          onTap: (int index) {
            setState(() {
              _navigatorIndex = index;
            });
          },
        ),
      ),
    );
  }
}
