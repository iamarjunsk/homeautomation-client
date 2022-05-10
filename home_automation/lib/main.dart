import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_automation/swit.dart';
import 'package:http/http.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url = "http://192.168.97.87:5000/getdata";
  final geturl = "http://192.168.97.87:5000/";
  var switStat;
  var s1 = "OFF";
  var s2 = "OFF";
  var s3 = "OFF";
  // void setNiram() {
  //   // s1c = switStat['switch1'] ? Colors.red : Colors.green;
  //   // s2c = switStat['switch2'] ? Colors.red : Colors.green;
  //   // s3c = switStat['switch3'] ? Colors.red : Colors.green;
  //   // print(s2c.toString());
  //   print(switStat);
  // }

  void phoneData() async {
    try {
      final response = await post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"switch": "switch2", "code": "trojon"}));
      print(response.body);
      final d = jsonDecode(response.body);
      var switStat = d['data'];
      print(switStat);
      if (switStat['switch2']) {
        getBattery();
      }
      // setNiram();
      // var sw = Swit.fromJson(d['data']);
    } catch (er) {
      print("er");
    }
  }

  buttonOne() async {
    try {
      final response = await post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"switch": "switch1", "code": "trojon"}));
      print(response.body);
      final d = jsonDecode(response.body);
      var switStat = d['data'];
      print(switStat);
      // setNiram();
      // var sw = Swit.fromJson(d['data']);
    } catch (er) {
      print("er");
    }
  }

  buttonThree() async {
    try {
      final response = await post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"switch": "switch3", "code": "trojon"}));
      print(response.body);
      final d = jsonDecode(response.body);
      var switStat = d['data'];
      print(switStat);
      // setNiram();
      // var sw = Swit.fromJson(d['data']);
    } catch (er) {
      print("er");
    }
  }

  getBattery() async {
    while (true) {
      // print(
      //     "Battery Health: ${(await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel}");
      var batLev = (await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel;
      if (batLev == 100) {
        phoneData();

        break;
      }
      final timer = Timer(const Duration(seconds: 10), () {
        // Navigate to your favorite place
      });
    }
  }

  void getData() async {
    // print(bstat);
    try {
      final response = await get(Uri.parse(geturl));
      final d = jsonDecode(response.body);
      var switStat = d['data'];
      // print(s2c);
      print(switStat);
      // await getBattery(d['data']['switch2']);
      // setNiram();
      if (switStat['switch1']) {
        setState(() {
          s1 = "ON";
        });
      } else {
        setState(() {
          s1 = "OFF";
        });
      }
      if (switStat['switch2']) {
        setState(() {
          s2 = "ON";
        });
      } else {
        setState(() {
          s2 = "OFF";
        });
      }
      if (switStat['switch3']) {
        setState(() {
          s3 = "ON";
        });
      } else {
        setState(() {
          s3 = "OFF";
        });
      }
    } catch (er) {
      print("error");
    }
    // if (switStat) {
    //     s1 = switStat['switch1'];
    //     s2 = switStat['switch2'];
    //     s3 = switStat['switch3'];
    //   }
    // setState(() {
    //   s1 = switStat;
    // });
    // s1 = switStat;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: buttonOne,
                child: Text("Switch 1"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
              ElevatedButton(
                onPressed: phoneData,
                child: Text("Phone"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
              ElevatedButton(
                onPressed: buttonThree,
                child: Text("Switch 3"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                s1.toString(),
                textScaleFactor: 1.3,
              ),
              Text(
                s2,
                textScaleFactor: 1.3,
              ),
              Text(
                s3,
                textScaleFactor: 1.3,
              )
            ],
          )
        ],
      )),
    ));
  }
}
// Center(
//           child: ElevatedButton(
//               onPressed: postData,
//               child: Text("Button 1"),
//               style: ElevatedButton.styleFrom(primary: Colors.green)),
//         ),