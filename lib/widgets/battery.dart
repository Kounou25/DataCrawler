import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class Batterie extends StatelessWidget {
  Batterie({super.key});
  final Battery _battery = Battery();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<int>(
          future: _battery.batteryLevel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == snapshot.hasError) {
              return Text('une erreur s\'es produite !');
            } else {
              return Text("niveau de la batterie: ${snapshot.data}");
            }
          }),
    );
  }
}
