import 'package:flutter/material.dart';
import 'package:flutter_app/data.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

import '../ui_task/size_config.dart';
import '../ui_task/theme.dart';
import '../ui_task/widgets/button.dart';
import '../ui_task/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.index});
  final int index;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime _selectedDate = DateTime.now();
  // final TaskController _taskController = Get.put(TaskController());
  int count = 0;
  @override
  void initState() {
    // _taskController.initDb(widget.index).then((value) {
    //   print('-------database intialized');
    //   _taskController.getTasks();
    // });
    super.initState();
  }

  String setTitle(int index) {
    switch (index) {
      case 0:
        return "Thứ 2";

      case 1:
        return "Thứ 3";
      case 2:
        return "Thứ 4";
      case 3:
        return "Thứ 5";
      case 4:
        return "Thứ 6";
      case 5:
        return "Thứ 7";

      default:
        return "Chủ Nhật";
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      appBar: _customAppBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 6,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  AppBar _customAppBar() {
    return AppBar(
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
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: subHeadingStyle,
              ),
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () {},
          )
          // onTap: () async {
          //   // await Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   //     builder: (context) => const AddTaskPage()));
          //   await Get.to(() => const AddTaskPage());
          //   _taskController.getTasks();
          // }),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: _selectedDate,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        )),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    // _taskController.getTasks();
  }

  void setInitDay(int index) {
    dayObjectList[index].title = setTitle(index);
    //print(dayObjectList[index].title);
    dayObjectList[index].id = index;
    // print(dayObjectList[index].id);

    dayObjectList[index].second = 0;
    dayObjectList[index].color = index % 2 == 0 ? 2 : 1;
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          // print(index);
          if (count < 8) {
            //print("ban dau khoi tao");
            setInitDay(index);
            count++;
          }

          // print(task.id);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1375),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () => _showBottomSheet(context, dayObjectList[index]),
                  child: TaskTile(task: dayObjectList[index]),
                ),
              ),
            ),
          );
        },
        itemCount: 7,
      ),
      // Obx(() {
      //   if (_taskController.taskList.isEmpty) {
      //     return _noTaskMsg();
      //   } else {
      //     return RefreshIndicator(
      //       onRefresh: _onRefresh,
      //       child:
      //       ListView.builder(
      //         scrollDirection: SizeConfig.orientation == Orientation.landscape
      //             ? Axis.horizontal
      //             : Axis.vertical,
      //         itemBuilder: (BuildContext context, int index) {
      //           var task = _taskController.taskList[index];

      //           if (task.repeat == 'Daily' ||
      //               task.date == DateFormat.yMd().format(_selectedDate) ||
      //               (task.repeat == 'Weekly' &&
      //                   _selectedDate
      //                               .difference(
      //                                   DateFormat.yMd().parse(task.date!))
      //                               .inDays %
      //                           7 ==
      //                       0) ||
      //               (task.repeat == 'Monthly' &&
      //                   DateFormat.yMd().parse(task.date!).day ==
      //                       _selectedDate.day)) {
      //             try {
      //               /*   var hour = task.startTime.toString().split(':')[0];
      //               var minutes = task.startTime.toString().split(':')[1]; */
      //               var date = DateFormat.jm().parse(task.startTime!);
      //               // ignore: unused_local_variable
      //               var myTime = DateFormat('HH:mm').format(date);
      //             } catch (e) {
      //               print('Error parsing time: $e');
      //             }
      //           } else {
      //             Container();
      //           }
      //           return AnimationConfiguration.staggeredList(
      //             position: index,
      //             duration: const Duration(milliseconds: 1375),
      //             child: SlideAnimation(
      //               horizontalOffset: 300,
      //               child: FadeInAnimation(
      //                 child: GestureDetector(
      //                   onTap: () => _showBottomSheet(context, task),
      //                   child: TaskTile(task: task),
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //         itemCount: _taskController.taskList.length,
      //       ),
      //     );
      //   }
      // }),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 220,
                        ),
                  SvgPicture.asset(
                    'assets/images/task.svg',
                    // ignore: deprecated_member_use
                    color: primaryClr.withOpacity(0.5),
                    height: 90,
                    semanticsLabel: 'Task',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 120,
                        )
                      : const SizedBox(
                          height: 180,
                        ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    TimeOfDay selectedTime = TimeOfDay.now();

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null && picked != selectedTime) {
        setState(() {
          selectedTime = picked;
          dayObjectList[task.id!.toInt()].hour = selectedTime.hour;
          dayObjectList[task.id!.toInt()].minute = selectedTime.minute;
        });
        Get.back();
      }
    }

    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.39),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            // Flexible(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            _buildBottomSheet(
                label:
                    'Time Start: ${dayObjectList[task.id!.toInt()].hour}:${dayObjectList[task.id!.toInt()].minute}',
                onTap: () {
                  _selectTime(context);
                },
                clr: Colors.amber),
            _buildBottomSheet(
                label: 'Time Last: ${dayObjectList[task.id!.toInt()].timer}',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter Time',
                            hintText: 'e.g., 15',
                          ),
                          onSubmitted: (String value) {
                            // Xử lý giá trị nhập vào ở đây
                            setState(() {
                              dayObjectList[task.id!.toInt()].timer =
                                  int.tryParse(value) ?? 15;
                            });
                            Get.back();
                          },
                        ),
                      );
                    },
                  );
                },
                clr: Colors.amber),
            _buildBottomSheet(
                label: 'On Task',
                onTap: () {
                  // NotifyHelper().cancelNotification(task);
                  // _taskController.markTaskAsCompleted(task.id!);
                  setState(() {
                    task.status = true;
                    dayObjectList[task.id!.toInt()].status = true;

                    updateValveDay(dayObjectList[task.id!.toInt()]);
                  });
                  Get.back();
                },
                clr: primaryClr),
            _buildBottomSheet(
                label: 'Off Task',
                onTap: () {
                  // NotifyHelper().cancelNotification(task);
                  // _taskController.deleteTasks(task);
                  setState(() {
                    task.status = false;
                    dayObjectList[task.id!.toInt()].status = false;

                    updateValveDay(dayObjectList[task.id!.toInt()]);
                  });
                  Get.back();
                },
                clr: Colors.red[300]!),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: primaryClr),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ));
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 45,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
