import 'package:flutter/material.dart';
import 'package:flutter_app/screens/MainPage.dart';

class HostPage extends StatefulWidget {
  const HostPage({
    super.key,
  });
  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  final TextEditingController _portcontroller =
      TextEditingController(text: "3001");
  final TextEditingController _ipcontroller =
      TextEditingController(text: "192.168.128.191");
  // String jsonData =
  //     '{\n"_id":1,\n"modeManual": "manual_on",\n"modeAuto": "sensor_off",\n"dataSensor": "21.5-22.3|45-47"}';

  @override
  Widget build(BuildContext context) {
    // Sensor dataSensor = Sensor.fromJson(jsonDecode(jsonData));
    // dataSensor.getData();
    // print(dataSensor.temp)

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Obx(() => Text(sensorController.dataSensor.toString())),
              TextFormField(
                controller: _ipcontroller,
                decoration: const InputDecoration(
                  prefixText: 'IP: ',
                ),
              ),
              TextFormField(
                controller: _portcontroller,
                decoration: const InputDecoration(
                  prefixText: 'Port: ',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(
                          // ip: _ipcontroller.text,
                          // port: _portcontroller.text,
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text('ENTER'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
