import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Bottomfield extends StatelessWidget {
  TextEditingController titleController;
  TextEditingController descriptionController;
  int? id;
  VoidCallback? onpressed;
  Bottomfield({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.id,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 120,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all(bannerColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: onpressed,
              child: Text(id == null ? 'Create New' : 'Update'),
            ),
          ),
        ],
      ),
    );
  }
}
