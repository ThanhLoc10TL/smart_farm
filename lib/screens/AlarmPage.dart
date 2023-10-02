import 'package:flutter/material.dart';
import 'package:flutter_app/data.dart';

import '../utils/theme_data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      color: CustomColors.pageBackgroundColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Alarm",
              style: TextStyle(
                // fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            //Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Expanded(
              child: ListView(
                children: alarms.map((alarm) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.red],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.label,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Office',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir')),
                            // Switch(value: true, onChanged: (bool value) {}),
                          ],
                        ),
                      ],
                    ),
                    height: 100,
                  );
                }).toList(),
              ),
            ),
          ]),
    );
  }
}
