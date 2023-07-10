import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shoes_shop_app/components/auth_builder.dart';
import 'package:shoes_shop_app/components/loading_builder.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/controller/loading_controller.dart';
import 'package:shoes_shop_app/views/cart/cart_page.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/home/home_page.dart';
import 'package:shoes_shop_app/views/order/orders_page.dart';
import 'package:shoes_shop_app/views/profile/profile_page.dart';
import 'package:shoes_shop_app/views/wallet/wallet_page.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  var _selectedIndex = 0;

  final AuthController authController = Get.put(AuthController());
  final LoadingController loadingController = Get.put(LoadingController());

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    OrdersPage(),
    CartPage(),
    WalletPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  static const selectedColor =
      ColorFilter.mode(AppColors.primaryTextColor, BlendMode.srcIn);
  static const unSelectedColor =
      ColorFilter.mode(AppColors.secondaryTextColor, BlendMode.srcIn);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/house_icon.svg",
                  colorFilter:
                      _selectedIndex == 0 ? selectedColor : unSelectedColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/bag_icon.svg",
                  colorFilter:
                      _selectedIndex == 1 ? selectedColor : unSelectedColor,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/cart_icon.svg",
                  colorFilter:
                      _selectedIndex == 2 ? selectedColor : unSelectedColor,
                ),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/wallet_icon.svg",
                  colorFilter:
                      _selectedIndex == 3 ? selectedColor : unSelectedColor,
                ),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/person_icon.svg",
                  colorFilter:
                      _selectedIndex == 4 ? selectedColor : unSelectedColor,
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            onTap: _onItemTapped,
          ),
        ),
        AuthBuilder(authController: authController),
        LoadingBuilder(loadingController: loadingController),
      ],
    );
  }
}
