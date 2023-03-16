import 'package:flutter/material.dart';

class CardTiles extends StatelessWidget {
  String description;
  String title;
  VoidCallback? ontapped;
  CardTiles(
      {super.key,
      required this.title,
      required this.description,
      required this.ontapped});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      shadowColor: Colors.grey,
      color: Colors.white,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 5,
          bottom: 5,
        ),
        child: ListTile(
          trailing: const Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onTap: ontapped,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
