import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset("assets/images/find_flow_logo.png", height: 30),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}