import 'package:bigdata_frontend_test/common/colors.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Aggro',
          ),
        ),
        foregroundColor: PRIMARY_TEXT_COLOR,
      );
    }
  }
}

class DefaultLayout2 extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  const DefaultLayout2({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar2(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar2() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Aggro',
          ),
        ),
        foregroundColor: PRIMARY_TEXT_COLOR,
      );
    }
  }
}
