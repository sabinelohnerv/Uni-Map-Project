import 'package:flutter/material.dart';

class BuildingInfo extends StatelessWidget {
  const BuildingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nombre'),
      content: const Text('Detalles'),
      actions: <Widget>[
        TextButton(
          child: const Text('Ver más'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
