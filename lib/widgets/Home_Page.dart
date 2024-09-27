import 'package:crawler/widgets/battery.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text(
            "Urban Crawler",
            style: TextStyle(),
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: FutureBuilder<AndroidDeviceInfo>(
                future: deviceInfo.androidInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    AndroidDeviceInfo InfoTel = snapshot.data!;
                    return Center(
                      child: Text(
                          "Marque: ${InfoTel.brand}\n Model: ${InfoTel.model}🤣\n id const: ${InfoTel.id}\n interName: ${InfoTel.device}\n materiel : ${InfoTel.hardware}\n Fabricant: ${InfoTel.manufacturer}\n android sdk: ${InfoTel.version.sdkInt}\n version android: ${InfoTel.version.release}"),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ),
          Batterie(),
        ],
      ),
    );
  }
}
