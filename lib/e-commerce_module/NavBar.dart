import 'package:flutter/material.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';

import 'Classes/Constants.dart';
import 'Drawer/MainHome.dart';
import 'OtherPages/CartPage.dart';
import 'OtherPages/MorePage.dart';
import 'OtherPages/OrdersPage.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 1;

  final iconList = [
    TabItemIcon(iconData: Icons.home, curveColor: Colors.orange),
    TabItemIcon(iconData: Icons.shopping_cart, curveColor: Colors.green),
    TabItemIcon(iconData: Icons.list, curveColor: Colors.orange),
    TabItemIcon(iconData: Icons.settings, curveColor: Colors.green),
  ];
  void onChangeTab(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: iconList.length,
      child: Scaffold(
        body: TabBarView(
          children: [MainHome(), CartPage(), OrdersPage(), MorePage()],
        ),
        bottomNavigationBar: JumpingTabBar(
          onChangeTab: onChangeTab,
          circleGradient: LinearGradient(
            colors: [
              kPrimaryColor,
              kWhiteColor,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          items: iconList,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}
