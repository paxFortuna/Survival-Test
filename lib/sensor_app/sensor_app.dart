import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorApp extends StatefulWidget {
  const SensorApp({super.key});

  @override
  State<SensorApp> createState() => _SensorAppState();
}

class _SensorAppState extends State<SensorApp> {
  @override
  Widget build(BuildContext context) {
    // 가로모드
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    final centerX = MediaQuery.of(context).size.width / 2 - 50;
    final centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      // appBar: AppBar(title: Text('수평계 앱')),
      body: Stack(
        children: [
          StreamBuilder<AccelerometerEvent>(
            stream: accelerometerEvents,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final event = snapshot.data!;
              List<double> accelerometerValues = [event.x, event.y, event.z];
              // print(accelerometerValues);
              return Positioned(
                left: centerX + event.y *20,
                top: centerY + event.x *20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  height: 100,
                  width: 100,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
