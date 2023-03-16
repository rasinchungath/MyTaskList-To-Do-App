import 'package:flutter/material.dart';

import '../constants/colors.dart';

void snackbar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 400),
      content: Text(content),
    ),
  );
}

AppBar appBar() {
  return AppBar(
    backgroundColor: bannerColor,
    elevation: 0,
    leading: const Icon(Icons.menu),
    title: const Text('MyTaskList'),
    centerTitle: true,
  );
}

FloatingActionButton floatingButton({required VoidCallback onpressed}) {
  return FloatingActionButton(
    backgroundColor: bannerColor,
    onPressed: onpressed,
    child: const Icon(Icons.add),
  );
}
