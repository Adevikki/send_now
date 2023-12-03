import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/colors.dart';
import '../../data/model/nav_bar_item.dart';
import '../../features/home/home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
  });

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> with WidgetsBindingObserver {
  int selectedTab = 0;
  bool isVisible = true;
  GlobalKey nNavBarKey = GlobalKey();
  // GlobalKey<HomePageWrapperState> homePageKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // void _selectedTab(int index) {
  //   setState(() {
  //     selectedTab = index;
  //   });

  //   // If "Home" tab is selected (index 0), inform the parent widget to show the order screen
  //   if (index == 0) {
  //     widget.onShowOrderScreen(true);
  //   }
  // }

  void _selectedTab(int index) => setState(() => selectedTab = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNNavBar(
        key: nNavBarKey,
        selectedColor: SendNowColors.primaryColor,
        onTabSelected: _selectedTab,
        index: selectedTab,
        items: const [
          NavBarItem(
            icon: Assets.home,
            // selectedicon: Assets.homeFill,
            text: "",
          ),
          NavBarItem(
            icon: Assets.addFunds,
            // selectedicon: Assets.addFunds,
            text: "",
          ),
          NavBarItem(
            icon: Assets.circles,
            // selectedicon: Assets.circlesFill,
            text: "",
          ),
          NavBarItem(
            icon: Assets.settings,
            // selectedicon: Assets.settingsFill,
            text: "",
          ),
        ],
        centerItemText: '',
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          HomePage(
            onTap: () => _selectedTab(3),
            showYourOrderWidget: isVisible,
            onResetState: () {
              setState(() {
                selectedTab = 0;
                isVisible = true;
              });
              final GlobalKey<HomePageState> homePageKey = nNavBarKey
                  .currentState!.widget.key as GlobalKey<HomePageState>;
              homePageKey.currentState?.resetState();
            },
          ),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}

class BottomNNavBar extends StatefulWidget {
  const BottomNNavBar({
    super.key,
    required this.items,
    required this.centerItemText,
    this.height = 80.0,
    this.iconSize = 30.0,
    required this.selectedColor,
    required this.onTabSelected,
    required this.index,
  });
  final List<NavBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color selectedColor;
  final ValueChanged<int> onTabSelected;
  final int index;

  @override
  State<StatefulWidget> createState() => BottomNNavBarState();
}

class BottomNNavBarState extends State<BottomNNavBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: widget.onTabSelected,
      );
    });

    return BottomAppBar(
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      child: Row(children: items),
    );
  }

  Widget _buildTabItem({
    required NavBarItem item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: InkWell(
          onTap: () => onPressed!(index!),
          child: Container(
            color: SendNowColors.greyBorder,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  (widget.index == index) ? item.icon : item.icon,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class HomePageWrapper extends StatefulWidget {
//   final VoidCallback? onResetState;

//   const HomePageWrapper({Key? key, this.onResetState}) : super(key: key);

//   @override
//   HomePageWrapperState createState() => HomePageWrapperState();
// }

// class HomePageWrapperState extends State<HomePageWrapper> {
//   void resetState() {
//     widget.onResetState?.call();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HomePage(
//       onResetState: widget.onResetState,
//     );
//   }
// }
