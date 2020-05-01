import 'package:flutter/material.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/settings_page.dart';
import 'package:frontend/pages/widgets_page.dart';
import 'package:frontend/widgets/side_bar.dart';

import 'food_item_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final page = ["MealCare", "Profile", "Settings", "Widgets"];
  PageController pageController;
  final ScaffoldKey = new GlobalKey<ScaffoldState>();

  void logout() {
    // Note this Push Replacement is only if this foodItemPage is the parent of all the next pages.
    print("Log out pressed");
    Navigator.pushReplacementNamed(context, "/");
  }

  void changePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
            onPressed: () {
              print("object");
              ScaffoldKey.currentState.openEndDrawer();
            },
            icon: Icon(
              Icons.dehaze,
              color: Colors.green,
              size: 28.0,
            ))
      ],
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
      // Add Logout
      leading: new Text(""),
      centerTitle: true,
      title: Column(
        children: <Widget>[
          Text(
            page[pageIndex],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25),
          ),
          Text(
            "Volunteer",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.green, fontSize: 12, letterSpacing: 3),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      endDrawer: Drawer(child: SideBar(changePage, logout)),
      appBar: buildAppBar(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          FoodItemPage(),
          ProfilePage(),
          SettingsPage(),
          WidgetsPage(), // need to remove this before deployment.
        ],
      ),
    );
  }
}