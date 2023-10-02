import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter_app/screens/TaskPage.dart';
import 'package:flutter_app/screens/ThershPage.dart';
import 'package:get/get.dart';

import '../../controllers/sensor_controller.dart';
import '../../models/farm/sensor.dart';
import 'package:flutter_app/data.dart';

bool isSent = false;

class ModuleWidget extends StatefulWidget {
  const ModuleWidget({super.key, required this.index});
  final int index;

  @override
  State<ModuleWidget> createState() => _ModuleWidgetState();
}

class _ModuleWidgetState extends State<ModuleWidget> {
  final SensorController sensorController = Get.put(SensorController());
  late bool stateValve = false,
      isCon = false,
      state1 = false,
      state2 = false,
      state3 = false,
      state4 = false;

  Widget showData(bool state) {
    stateValve = state;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 00.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 140,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomValve(
                        index: 1,
                        state: dataSensor.statusSubValve?.valve1 == 1
                            ? true
                            : false),
                    CustomValve(
                        index: 2,
                        state: dataSensor.statusSubValve?.valve2 == 1
                            ? true
                            : false)
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomValve(
                      index: 3,
                      state: dataSensor.statusSubValve?.valve3 == 1
                          ? true
                          : false),
                  CustomValve(
                      index: 4,
                      state:
                          dataSensor.statusSubValve?.valve4 == 1 ? true : false)
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Slave ${widget.index + 1}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.settings))
                  ],
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10.0)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                  color: !stateValve ? Colors.grey[900] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/valve.png",
                        height: 40,
                        color: stateValve ? Colors.black : Colors.white,
                      ),
                      Transform.rotate(
                        angle: -3.14 / 2,
                        child: CupertinoSwitch(
                          value: stateValve,
                          onChanged: (value) {
                            if (!isSent) {
                              value
                                  ? globalData['infor']['status']['manual'] = 1
                                  : globalData['infor']['status']['manual'] = 0;
                              sendData();
                              isSent = true;
                              setState(() {
                                stateValve = value;
                                // value
                                //     ? dataSensor.modeSensor = "sensor_on"
                                //     : dataSensor.modeSensor = "sensor_off";
                                // dataSensor.modeSensor == 'sensor_on'
                                //     ? stateValve = true
                                //     : stateValve = false;
                                // print('$value        $stateValve\n');
                                // print(dataSensor.dataSensor);
                              });
                            } else {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.bottomSlide,
                                  showCloseIcon: true,
                                  title: "Warning",
                                  desc: "Please wait for ACK",
                                  // btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    setState(() {});
                                  }).show();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Butterfly\n',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: stateValve ? Colors.black : Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Valve ${widget.index + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: stateValve ? Colors.black : Colors.white,
                          ),
                        )
                      ])),
                      IconButton(
                          onPressed: () {
                            Get.to(() => TaskPage(index: widget.index));
                          },
                          icon: const Icon(Icons.settings),
                          color: stateValve ? Colors.black : Colors.white)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/sensor.png",
                        height: 40,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${dataSensor.temp}\n',
                                ),
                                TextSpan(text: '${dataSensor.humi}')
                              ])),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Sensor ${widget.index + 1}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => const ThershPage());
                          },
                          icon: const Icon(Icons.settings))
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (isSent && !isCon) {
    //   // Hiển thị thông báo khi biến flag là true
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text('Notification'),
    //           content: Text('Controllable'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text('Close'),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   });
    //   isCon = true;
    // }
    return Obx(() => sensorController.isLoadingHttp.value
        ? const CircularProgressIndicator()
        : StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if ((snapshot.hasData) && (snapshot.data.length > 5)) {
                print(snapshot.data);
                // Map<String, dynamic> jsonMap = json.decode(snapshot.data);
                // var dataTemp = Sensor.fromJson(json.decode(snapshot.data));
                // print(dataTemp.dataSensor);
                // return Text('${dataTemp.modeManual}+${dataTemp.temp}');
                dataSensor = Sensor.fromJson(json.decode(snapshot.data));
                dataSensor.getData();

                print(dataSensor.modeSensor);
                if (isSent) isSent = false;
                return showData(dataSensor.stateValve);
              }
              print("ban dau");

              if (!sensorController.dataTest[0].dataSensor!.contains("101")) {
                dataSensor = sensorController.dataTest[0];
              }
              print(dataSensor.statusSubValve?.valve1);

              return showData(dataSensor.stateValve);
            }));
  }
}

class CustomValve extends StatefulWidget {
  CustomValve({super.key, required this.index, required this.state});
  int index;
  bool state;
  @override
  State<CustomValve> createState() => _CustomValveState();
}

class _CustomValveState extends State<CustomValve> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Valve ${widget.index}',
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        CupertinoSwitch(
            value: widget.state,
            onChanged: (value) {
              if (!isSent) {
                isSent = true;
                setState(() {
                  widget.state = value;
                  switch (widget.index) {
                    case 1:
                      value
                          ? globalData['infor']['statusValve']['valve1'] = 1
                          : globalData['infor']['statusValve']['valve1'] = 0;
                      break;
                    case 2:
                      value
                          ? globalData['infor']['statusValve']['valve2'] = 1
                          : globalData['infor']['statusValve']['valve2'] = 0;
                      break;
                    case 3:
                      value
                          ? globalData['infor']['statusValve']['valve3'] = 1
                          : globalData['infor']['statusValve']['valve3'] = 0;
                      break;
                    default:
                      value
                          ? globalData['infor']['statusValve']['valve4'] = 1
                          : globalData['infor']['statusValve']['valve4'] = 0;
                      break;
                  }
                });
                sendData();
              } else {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.bottomSlide,
                    showCloseIcon: true,
                    title: "Warning",
                    desc: "Please wait for ACK",
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      setState(() {});
                    }).show();
              }
            }),
      ],
    );
  }
}
