import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widgets/navigation_bar.dart';
import 'credit_screen.dart';
import 'home_page.dart';
import 'loading_screen.dart';
import 'summery.dart';


class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isLoading = false;
  bool homeDataLoded = false;

  @override
  void initState() {
    super.initState();
    if(homeDataLoded==false){
      initData();
    }
  }

  void initData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<HomeProvider>(context,listen: false).getData();
    }catch(e){
      showDialog(
        context: context,
        builder: (BuildContext ctx){
          return AlertDialog(
            title: Text(e.toString()),
          );
        }
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  int currentPageIndex = 0;
  List<Widget> pages = [HomePage(),CreditScreen(),Summery()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key("RootPage"),
        backgroundColor: Colors.white,
        body: isLoading ? LoadingScreen() : pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
            onTap: (int i) {
              setState(() {
                currentPageIndex = i;
              });
            },
            index: currentPageIndex
        )
    );
  }
}