import 'dart:convert';

import 'package:flutter_app/api/farm_api.dart';
import 'package:flutter_app/models/farm/sensor.dart';
import 'package:get/get.dart';

class SensorController extends GetxController {
  var isLoadingHttp = true.obs;
  // var dataSensor = "".obs;
  final RxList<Sensor> dataTest = <Sensor>[].obs;

  @override
  void onInit() {
    fetchSensorHttp();
    super.onInit();
  }

  void fetchSensorHttp() async {
    try {
      isLoadingHttp(true);
      var data = await FarmApi.fetchDataHttp();
      if (data != null) {
        // dataSensor.value = data;
        // Phân tích chuỗi JSON thành danh sách đối tượng
        List<dynamic> jsonList = json.decode(data);

        // Lấy ra trường "valveList" từ đối tượng JSON đầu tiên
        List<dynamic> valveList = jsonList[0]["valveList"];

        dataTest
            .assignAll(valveList.map((json) => Sensor.fromJson(json)).toList());
        for (var element in dataTest) {
          element.getData();
        }
      }
    } finally {
      isLoadingHttp(false);
    }
  }
}
