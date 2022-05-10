import 'dart:convert';

import 'dart:ffi';

class Swit {
  late final Bool switch1;
  late final Bool switch2;
  late final Bool switch3;
  Swit(this.switch1, this.switch2, this.switch3);
  // factory Switch.fromJson(Map<String, dynamic> json) =>{
  //   Switch(
  //     switch1:json['switch1'],
  //     switch2:json['switch2'],
  //     switch3:json['switch3'],
  //   );
  // }
  Swit.fromJson(Map<String, dynamic> json)
      : switch1 = json['switch1'],
        switch2 = json['switch2'],
        switch3 = json['switch3'];
}
