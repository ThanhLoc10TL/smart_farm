import 'dart:math';

import 'package:flutter/material.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/api/farm_api.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../ui_task/theme.dart';

class HumidChartPage extends StatefulWidget {
  const HumidChartPage({super.key});

  @override
  State<HumidChartPage> createState() => _HumidChartPageState();
}

class _HumidChartPageState extends State<HumidChartPage> {
  late List<DataChart> _chartData1, _chartData2;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _chartData1 = getChartData();
    _chartData2 = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        enableDoubleTapZooming: true,
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 2,
        selectionRectColor: Colors.grey,
        enablePanning: true,
        zoomMode: ZoomMode.x,
        enableMouseWheelZooming: true,
        maximumZoomLevel: 0.1);
    super.initState();
  }

  DateTime? _startDate;
  DateTime? _endDate;
  List<String> xAxisLabels = [];

  List<double> dataHumid1 = [], dataHumid2 = [];
  List<DateTime> dataTime = [];

  int numberOfTicks = 0; // Số lượng điểm trên trục x
  // Danh sách nhãn trục x
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo,
          ),
        ),
        // IconButton(
        //   onPressed: () {
        //     ThemeServices().switchTheme();
        //   },
        //   icon: Icon(
        //     Get.isDarkMode
        //         ? Icons.wb_sunny_outlined
        //         : Icons.nightlight_round_outlined,
        //     size: 24,
        //     color: Get.isDarkMode ? Colors.white : darkGreyClr,
        //   ),
        // ),
        elevation: 0,
        // ignore: deprecated_member_use
        backgroundColor: context.theme.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.cleaning_services_outlined,
                size: 24, color: Get.isDarkMode ? Colors.white : darkGreyClr),
            onPressed: () {
              // notifyHelper.cancelAllNotifications();
              //_taskController.deleteAllTasks();
            },
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 18,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildDateFields(),
            const SizedBox(height: 20),
            _buildTemperatureChart(_chartData1, 1),
            const SizedBox(height: 20),
            _buildTemperatureChart(_chartData2, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFields() {
    return Column(
      children: <Widget>[
        DateTimeField(
          format: DateFormat("yyyy-MM-dd HH:mm"),
          decoration: InputDecoration(
            labelText: "Ngày bắt đầu",
          ),
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              _startDate = DateTimeField.combine(date, time);
              setState(() {});
              return _startDate;
            } else {
              return currentValue;
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        DateTimeField(
          format: DateFormat("yyyy-MM-dd HH:mm"),
          decoration: InputDecoration(
            labelText: "Ngày kết thúc",
          ),
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              _endDate = DateTimeField.combine(date, time);
              setState(() {});
              return _endDate;
            } else {
              return currentValue;
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            // print(convertToDateTimeString("27/10/2023/23/18", 5));
            // print(
            //     DateTime.parse(convertToDateTimeString("27/10/2023/23/18", 5)).);
            // Xử lý việc vẽ biểu đồ nhiệt độ ở đây
            if (_startDate != null && _endDate != null) {
              // Gọi hàm để vẽ biểu đồ với khoảng thời gian đã chọn
              _drawTemperatureChart(_startDate!, _endDate!);
            }
          },
          child: const Text('Draw',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45)),
        ),
      ],
    );
  }

  Widget _buildTemperatureChart(List<DataChart> dataChart, int index) {
    return SfCartesianChart(
        title: ChartTitle(text: 'Humidity$index analysis (°C)'),
        //legend: const Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        zoomPanBehavior: _zoomPanBehavior,
        series: <ChartSeries>[
          LineSeries<DataChart, DateTime>(
              name: 'Humidity $index',
              dataSource: dataChart,
              xValueMapper: (DataChart data, _) => data.date,
              yValueMapper: (DataChart data, _) =>
                  index == 1 ? data.humid1 : data.humid2,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
              color: Colors.blueAccent,
              enableTooltip: true)
        ],
        primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            dateFormat: DateFormat('HH:mm\ndd-MM-yy'),
            // dateFormat: DateFormat.Hm(),
            intervalType: DateTimeIntervalType.auto,
            interactiveTooltip: const InteractiveTooltip(enable: false)),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}%',
            numberFormat: null,
            interactiveTooltip: const InteractiveTooltip(enable: false)));
  }

  void _drawTemperatureChart(DateTime startDate, DateTime endDate) async {
    // Ở đây, bạn có thể sử dụng thư viện fl_chart để vẽ biểu đồ nhiệt độ
    // và sử dụng dữ liệu nhiệt độ trong khoảng thời gian đã chọn để cập nhật biểu đồ.
    // Ví dụ: https://pub.dev/packages/fl_chart
    // Lấy dữ liệu nhiệt độ từ các biến và thêm vào danh sách
    dataHumid1.clear();
    dataHumid2.clear();
    dataTime.clear();
    var statusData = await FarmApi.getStatus(1, _startDate!, _endDate!);

    if (statusData != null) {
      for (int i = 0; i < statusData.length; i++) {
        for (int j = 0; j < statusData[i].sensorStatus!.length; j++) {
          dataHumid1.add(statusData[i].sensorStatus![j].value!.humid1!);
          dataHumid2.add(statusData[i].sensorStatus![j].value!.humid2!);
          dataTime.add(DateTime.parse(convertToDateTimeString(
              statusData[i].id!, statusData[i].sensorStatus![j].timeSave!)));

          // print(dataChart[data_len].date);
        }
      }
      // print("Status Data:");
      // print(statusData[0].sensorStatus?[0].value?.humid1);
    } else {
      print("Failed to fetch status data.");
    }

    // Tính toán số lượng điểm trên trục x dựa trên khoảng thời gian
    numberOfTicks = endDate.difference(startDate).inMinutes + 1;

    _chartData1.clear();
    _chartData2.clear();
    int count = 0, counter = 3;
    for (int i = 0; i < numberOfTicks; i++) {
      final currentTime = startDate.add(Duration(minutes: i));
      if (currentTime == startDate || currentTime == endDate) {
        _chartData1.add(DataChart(0.0, 0.0, currentTime));
        _chartData2.add(DataChart(0.0, 0.0, currentTime));
      } else {
        int index = dataTime.indexOf(currentTime);
        if (index == -1)
          count++;
        else {
          count = 0;
          _chartData1.add(
              DataChart(dataHumid1[index], dataHumid2[index], dataTime[index]));
          _chartData2.add(
              DataChart(dataHumid1[index], dataHumid2[index], dataTime[index]));
        }

        if (count >= 3) {
          counter++;
          //print(counter);
          if (counter % (sqrt(counter)).toInt() == 0) {
            _chartData1.add(DataChart(0.0, 0.0, currentTime));
            _chartData2.add(DataChart(0.0, 0.0, currentTime));
          }
        } else
          counter = 3;
      }
    }
    setState(() {});
  }
}

String convertToDateTimeString(String inputString, int minutes) {
  // Tách chuỗi thành các thành phần ngày, tháng, năm, giờ, phút
  final parts = inputString.split('/');

  if (parts.length == 5) {
    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];
    final hour = parts[3].padLeft(2, '0');
    // final minute = parts[4].padLeft(2, '0');
    final minute = minutes.toString().padLeft(2, '0');
    // Định dạng lại chuỗi theo định dạng yyyymmddTHHMM
    final formattedString = '$year$month${day}T$hour$minute';

    return formattedString;
  } else {
    // Trường hợp chuỗi không hợp lệ
    return 'Invalid input';
  }
}

List<DataChart> getChartData() {
  final List<DataChart> chartData = [
    DataChart(33.5, 35.6, DateTime.now()),
  ];
  return chartData;
}

class DataChart {
  double? humid1, humid2;
  DateTime? date;
  DataChart(this.humid1, this.humid2, this.date);
}
