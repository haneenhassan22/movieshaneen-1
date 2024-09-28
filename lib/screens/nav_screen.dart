// Date Created :16/july/2023
// Developer Name : Mazen sha//App Version : Version 1
// Date of Last Edit :18/july/2023
// Objectives: this class named NavScreen created for controlling the new navbar package with styling and
// the icons and screens that open on Tap navigation bar

// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use, must_be_immutable, sdk_version_since, await_only_futures, duplicate_ignore

import 'package:flutflix/colors.dart';
import 'package:flutflix/nav_bar_package.dart/model.dart';
import 'package:flutflix/nav_bar_package.dart/tab_view.dart';
import 'package:flutflix/screens/categories_screen.dart';
import 'package:flutflix/screens/home_screen.dart';
import 'package:flutflix/screens/search_screen.dart';
import 'package:flutflix/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  double screenWidth = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  @override
  void initState() {
    super.initState();

    screenWidth > 600
        ? SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ])
        : SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp,
          ]);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      SearchScreen(),
      CategoriesScreen(),
      WatchListScreen(),
    ];
  }

  int currentIndex = 0;

  void onScreenChanged(int index) {
    setState(() {
      FocusScope.of(context).unfocus();
      currentIndex = index;
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    var themeController;
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/home.svg',
            color: Color(0xFFFFBB3B),
            //  width: isTabletView ? 0.122.w : null,
          ),
          inactiveIcon: SvgPicture.asset('assets/home.svg', color: Colors.white
              // width: isTabletView ? 0.122.w : null,
              ),
          title: ("Home"),
          activeColorPrimary: Color(0xFFFFBB3B),
          inactiveColorPrimary: Colors.white),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/search.svg',
            color: Color(0xFFFFBB3B),
            //  width: isTabletView ? 0.122.w : null,
          ),
          inactiveIcon:
              SvgPicture.asset('assets/search.svg', color: Colors.white
                  // width: isTabletView ? 0.122.w : null,
                  ),
          title: ("Search"),
          activeColorPrimary: Color(0xFFFFBB3B),
          inactiveColorPrimary: Colors.white),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/movie.svg',
            color: Color(0xFFFFBB3B),
            //  width: isTabletView ? 0.122.w : null,
          ),
          inactiveIcon: SvgPicture.asset('assets/movie.svg', color: Colors.white
              // width: isTabletView ? 0.122.w : null,
              ),
          title: ("Browse"),
          activeColorPrimary: Color(0xFFFFBB3B),
          inactiveColorPrimary: Colors.white),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/watchlist.svg',
            color: Color(0xFFFFBB3B),
            //  width: isTabletView ? 0.122.w : null,
          ),
          inactiveIcon:
              SvgPicture.asset('assets/watchlist.svg', color: Colors.white
                  // width: isTabletView ? 0.122.w : null,
                  ),
          title: ("WatchList"),
          activeColorPrimary: Color(0xFFFFBB3B),
          inactiveColorPrimary: Colors.white),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final bool isTabletView = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: PersistentTabView(
          context,
          screens: _buildScreens(),
          items: _navBarsItems(),
          navBarHeight: 80,
          confineInSafeArea: true,
          hideNavigationBarWhenKeyboardShows: true,
          popActionScreens: PopActionScreensType.all,
          resizeToAvoidBottomInset: true,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style3,
          backgroundColor: Colours.scaffoldBgColor,
          onItemSelected: (index) {
            // Handle tab selection
            setState(() {});
          },
          padding: NavBarPadding.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
