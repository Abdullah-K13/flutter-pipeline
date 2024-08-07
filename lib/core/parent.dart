import 'package:flutter/material.dart';

class Parent extends StatefulWidget {
  final Widget? child;
  final PreferredSize? appBar;
  final bool avoidBottomInset;
  final Widget? floatingButton;
  final Widget? bottomNavigation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Key? scaffoldKey;
  final bool extendBodyBehindAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const Parent(
      {super.key,
      this.child,
      this.appBar,
      this.avoidBottomInset = true,
      this.floatingButton,
      this.backgroundColor,
      this.bottomNavigation,
      this.drawer,
      this.scaffoldKey,
      this.endDrawer,
      this.extendBodyBehindAppBar = false,
      this.floatingActionButtonLocation});

  @override
  ParentState createState() => ParentState();
}

class ParentState extends State<Parent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: widget.scaffoldKey,
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: widget.avoidBottomInset,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        appBar: widget.appBar,
        body: widget.child,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        floatingActionButton: widget.floatingButton,
        bottomNavigationBar: widget.bottomNavigation,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
      ),
    );
  }
}
