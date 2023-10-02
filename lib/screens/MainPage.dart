import 'package:flutter/material.dart';
import 'package:flutter_app/api/weather_api.dart';
import 'package:flutter_app/controllers/global_controller.dart';
import 'package:flutter_app/models/weather/weather_model.dart';
import 'package:flutter_app/screens/HumidChartPage.dart';
import 'package:flutter_app/screens/TempChartPage.dart';

import 'package:flutter_app/widgets/header_widget.dart';
import 'package:flutter_app/widgets/module/custom_module.dart';
import 'package:flutter_app/widgets/weather_widget.dart';

import 'package:get/get.dart';

// import 'package:web_socket_channel/web_socket_channel.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  WeatherApi client = WeatherApi();
  WeatherCurrent? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather(globalController.getLattitude().value,
        globalController.getLongitude().value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 76, 124, 91),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Stack(
                children: [
                  Positioned(
                      bottom: 8.0,
                      left: 4.0,
                      child: Text(
                        "Smart Farm App",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: null,
            ),
            ListTile(
              leading: const Icon(Icons.bubble_chart),
              title: const Text("Temperature Chart"),
              onTap: () {
                Get.to(() => const TempChartPage());
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HostPage()),
                //   (Route<dynamic> route) => false,
                // );
              },
            ),
            ListTile(
              leading: Icon(Icons.ssid_chart),
              title: Text("Humidity Chart"),
              onTap: () {
                Get.to(() => const HumidChartPage());
              },
            ),
            const ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("Contact"),
              onTap: null,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Get.to(() => const LoginPage());
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child:
              // ListView(scrollDirection: Axis.vertical, children: [
              //   AppBar(),
              //   //const HeaderWidget(),
              //   const ModuleWidget(),

              //   const ModuleWidget()
              // ]),
              Obx(() => globalController.checkLoading().isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          AppBar(),
                          const HeaderWidget(),
                          const SizedBox(height: 10),
                          // Text(globalController.getLattitude().value.toString()),
                          // Text(globalController.getLongitude().value.toString()),
                          FutureBuilder(
                              future: getData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return WeatherWidget(weatherData: data!);
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                          const SizedBox(height: 10),
                          const ModuleWidget(
                            index: 0,
                          ),
                          // const ModuleWidget(
                          //   index: 1,
                          // ),
                        ],
                      ),
                    ))),
    );
  }
}
// class MainPage extends StatefulWidget {
//   final String port, ip;
//   const MainPage({super.key, required this.ip, required this.port});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   final TextEditingController _controller = TextEditingController();

//   late WebSocketChannel _channel;

//   // final _channel = WebSocketChannel.connect(
//   //   Uri.parse('ws://192.168.128.191:3001'),
//   //   // Uri.parse('ws://${widget.host}'),
//   // );

//   @override
//   Widget build(BuildContext context) {
//     _channel = WebSocketChannel.connect(
//       //   Uri.parse('ws://192.168.128.191:3001'),
//       Uri.parse('ws://${widget.ip}:${widget.port}'),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Send a message'),
//               ),
//             ),
//             const SizedBox(height: 24),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: const Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//     }
//   }

//   @override
//   void dispose() {
//     _channel.sink.close();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(DiagnosticsProperty<WebSocketChannel>('_channel', _channel));
//   }
// }
