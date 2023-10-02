import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/data.dart';

class ThershPage extends StatefulWidget {
  const ThershPage({super.key});

  @override
  State<ThershPage> createState() => _ThershPageState();
}

class _ThershPageState extends State<ThershPage> {
  double low_t = 20.0, high_t = 30.0;
  bool stateSensor = dataSensor.modeSensor == "sensor_on" ? true : false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //appBar: AppBar(title: const Text("Setting Sensor")),
            backgroundColor: Colors.indigo.shade50,
            body: Container(
              margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.indigo,
                      ),
                    ),
                    const Text(
                      "Setting Sensor",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 135,
                      child: Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.indigo,
                        size: 28,
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.heat_pump),
                                  Text('${dataSensor.temp}°C'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.water_drop_outlined),
                                  Text('${dataSensor.humi}%'),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoSwitch(
                                    value: stateSensor,
                                    onChanged: (value) {
                                      setState(() {
                                        stateSensor = value;
                                        value
                                            ? globalData['infor']['status']
                                                ['sensor'] = 1
                                            : globalData['infor']['status']
                                                ['sensor'] = 0;
                                        globalData['infor']['status']
                                            ['manual'] = 3;
                                        globalData['infor']['status']['auto'] =
                                            3;
                                        globalData['infor']['sensor']['high'] =
                                            high_t.toInt();
                                        globalData['infor']['sensor']['low'] =
                                            low_t.toInt();
                                        sendData();
                                      });
                                    },
                                  ),
                                  Text(dataSensor.modeSensor == "sensor_on"
                                      ? 'Auto'
                                      : 'Manual'),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                "High threshold",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Slider(
                                max: 100,
                                value: high_t,
                                onChanged: (newVal) {
                                  setState(() {
                                    high_t = newVal;
                                  });
                                }),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0\u00B0'),
                                  Text('50\u00B0'),
                                  Text('100\u00B0'),
                                ],
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                "Low threshold",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Slider(
                                max: 100,
                                value: low_t,
                                onChanged: (newVal) {
                                  setState(() {
                                    low_t = newVal;
                                  });
                                }),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0\u00B0'),
                                  Text('50\u00B0'),
                                  Text('100\u00B0'),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ],
                )),
              ]),
            )));
  }
}
