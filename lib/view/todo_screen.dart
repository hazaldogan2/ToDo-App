import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controller/task_controller.dart';
import '../gui_kit/template.dart';
import '../switch_button.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TaskController controller = Get.put(TaskController());
  String dateText = "";
  String timeText = "";
  Color priorityColor = Colors.grey;
  int priorityInt = 0;
  DateTime date = DateTime.now();
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  void addNewRemainder() {
    final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());
    final GetXSwitchStateTime getXSwitchStateTime = Get.put(GetXSwitchStateTime());

    Get.bottomSheet(
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                      getXSwitchState.isSwitcheded = false;
                      getXSwitchStateTime.isSwitchededTime = false;
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                    )),
                const Text(
                  "New Remineder",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    final taskName = controller.titleTextEditingController.text;
                    final taskDesc = controller.noteTextEditingController.text;
                    final taskTag = controller.date.toString();
                    _addTasks(taskName: taskName, taskDesc: taskDesc, taskTag: taskTag);
                    controller.addTask(
                        controller.titleTextEditingController.text,
                        controller.noteTextEditingController.text,
                        controller.dateTextEditingController,
                        controller.timeTextEditingController,
                        controller.priorityController,
                        controller.date,
                        controller.priorityIntController);
                    getXSwitchState.isSwitcheded = false;
                    getXSwitchStateTime.isSwitchededTime = false;

                    Get.back();
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: controller.titleTextEditingController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    color: Color(0xffa2a3a3),
                    fontSize: 15,
                    fontFamily: 'Barlow'),
                hintText: "Title",
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                isDense: true,
                errorMaxLines: 3,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe4e4e4))),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe4e4e4))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe4e4e4))),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe4e4e4))),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: controller.noteTextEditingController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    color: Color(0xffa2a3a3),
                    fontSize: 15,
                    fontFamily: 'Barlow'),
                hintText: "Note",
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                isDense: true,
                errorMaxLines: 3,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 60,
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                details();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffcdcdcd).withOpacity(0.2),
                side: const BorderSide(width: 1, color: Colors.grey),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(20),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Details", style: TextStyle(color: Colors.black)),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
  void details() {
    final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());
    final GetXSwitchStateTime getXSwitchStateTime = Get.put(GetXSwitchStateTime());

    Get.bottomSheet(
      isScrollControlled: true,
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          getXSwitchState.isSwitcheded = false;
                          getXSwitchStateTime.isSwitchededTime = false;
                          controller.priorityController = priorityColor;
                          controller.priorityIntController = priorityInt;
                          Get.back();
                        },
                        child: const Text(
                          "Cancel",
                          style:
                          TextStyle(color: Colors.blueAccent, fontSize: 15),
                        )),
                    const Text(
                      "Details",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        getXSwitchState.isSwitcheded = false;
                        getXSwitchStateTime.isSwitchededTime = false;
                      },
                      child: GestureDetector(
                        onTap: () {
                          controller.dateTextEditingController = dateText;
                          controller.date=date;
                          if (getXSwitchStateTime.isSwitchededTime) {
                            controller.timeTextEditingController = timeText;
                          }
                          Get.back();
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 30.0,
                  right: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                  size: 20,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Date",
                              style:
                              TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GetBuilder<GetXSwitchState>(
                      builder: (_) => Switch(
                        value: getXSwitchState.isSwitcheded,
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Colors.green,
                        hoverColor: Colors.transparent,
                        onChanged: (value) {
                          getXSwitchState.changeSwitchState(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<GetXSwitchState>(
                builder: (_) => getXSwitchState.isSwitcheded
                    ? _buildDefaultSingleDatePickerWithValue()
                    : SizedBox.shrink(),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.access_time_filled_rounded,
                              color: Colors.white,
                              size: 20,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Time",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    GetBuilder<GetXSwitchStateTime>(
                      builder: (_) => Switch(
                        value: getXSwitchStateTime.isSwitchededTime,
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Colors.green,
                        hoverColor: Colors.transparent,
                        onChanged: (value) {
                          getXSwitchStateTime.changeSwitchStateTime(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: GetBuilder<GetXSwitchStateTime>(
                  builder: (_) => getXSwitchStateTime.isSwitchededTime
                      ? getTime()
                      : SizedBox.shrink(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      priority();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffcdcdcd).withOpacity(0.2),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Priority", style: TextStyle(color: Colors.black)),
                        Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 100.0),
                child: SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffcdcdcd).withOpacity(0.2),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Attach a file", style: TextStyle(color: Colors.black)),
                        Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
  void priority() {
    final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());
    final GetXSwitchStateTime getXSwitchStateTime = Get.put(GetXSwitchStateTime());

    Get.bottomSheet(
      Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                    getXSwitchState.isSwitcheded = false;
                    getXSwitchStateTime.isSwitchededTime = false;
                    controller.priorityController = priorityColor;
                    controller.priorityIntController = priorityInt;
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  )),
              const Text(
                "Priority",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  getXSwitchState.isSwitcheded = false;
                  getXSwitchStateTime.isSwitchededTime = false;
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, bottom: 20),
          child: TextElevatedButtonTemplate(
            height: 40,
            width: 80,
            text: "İmportant",
            textStyle: TextStyle(color: Colors.red, fontSize: 15),
            color: Colors.white30,
            onPressed: () {
              controller.priorityController = Colors.red;
              controller.priorityIntController = 2;
            },
            boxShadowColor: Colors.white10,
            elevation: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextElevatedButtonTemplate(
            height: 40,
            width: 80,
            text: "None",
            textStyle: TextStyle(color: Colors.grey, fontSize: 15),
            color: Colors.white30,
            onPressed: () {
              controller.priorityController = Colors.grey;
              controller.priorityIntController = 0;
            },
            boxShadowColor: Colors.white10,
            elevation: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextElevatedButtonTemplate(
            height: 40,
            width: 100,
            text: "Unimportant",
            textStyle: TextStyle(color: Colors.blue, fontSize: 15),
            color: Colors.white30,
            onPressed: () {
              controller.priorityController = Colors.blue;
              controller.priorityIntController = 1;
            },
            boxShadowColor: Colors.white10,
            elevation: 1,
          ),
        ),
      ]),
      backgroundColor: Colors.white,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget getTime() {
    DateTime _selectedTime = DateTime.now();
    String time = "-";

    return SizedBox(
      height: 90,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (newTime) {
          setState(() {
            _selectedTime = newTime;
            time = "${_selectedTime.hour} : ${_selectedTime.minute}";
            timeText = time;
          });
        },
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.amber[900],
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      centerAlignModePicker: true,
      useAbbrLabelForMonthModePicker: true,
      firstDate: DateTime(DateTime.now().year - 2, DateTime.now().month - 1,
          DateTime.now().day - 5),
      lastDate: DateTime(DateTime.now().year + 3, DateTime.now().month + 2,
          DateTime.now().day + 10),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );

    return Center(
      child: SizedBox(
        //  height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            CalendarDatePicker2(
              config: config,
              value: _singleDatePickerValueWithDefaultValue,
              onValueChanged: (dates) => setState(() {
                _singleDatePickerValueWithDefaultValue = dates;
                dateText = _getValueText(
                  config.calendarType,
                  _singleDatePickerValueWithDefaultValue,
                );
                date=_singleDatePickerValueWithDefaultValue.first!;
              }),
            ),
          ],
        ),
      ),
    );
  }

  String _getValueText( CalendarDatePicker2Type datePickerType, List<DateTime?> values) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty ? values.map((v) => v.toString().replaceAll('00:00:00.000', '')).join(', ') : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 10.0),
          child: TextElevatedButtonTemplate(
            height: 70,
            width: 350,
            text: "New Reminder",
            textStyle: const TextStyle(color: Colors.white, fontSize: 15),
            boxShadowColor: Colors.white,
            color: const Color(0xff151918),
            onPressed: () {
              addNewRemainder();
            },
            elevation: 0,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
                top: 80.0, bottom: 10.0, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Planlist",
                  style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.itemCount.value,
                  itemBuilder: ((context, index) {
                    return Slidable(
                      key: UniqueKey(),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: null,
                            backgroundColor:
                            Color.fromARGB(255, 191, 191, 191),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: null,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 400,
                            child: ListTile(
                              leading: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: controller.task.value[index].color ?? Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: SizedBox(
                                  width: 100,
                                  child: controller.task.value[index].title.isNotEmpty?
                                      Text(controller.task.value[index].title!) : Text("-")),
                              subtitle: SizedBox(
                                  width: 100,
                                  child: Text(
                                      controller.task.value[index].note!)),
                              trailing: Padding(
                                padding:  EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    Text(controller
                                        .task.value[index].dateTime!, style: TextStyle(color: Colors.black, fontSize: 13),),
                                    Text(controller.task.value[index].time!, style: TextStyle(color: Colors.grey, fontSize: 13),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),),
          ),
        ],
      ),
    );
  }


  Future _addTasks({required String taskName, required String taskDesc, required String taskTag}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('list').add(
      {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'taskTag': taskTag,
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance.collection('list').doc(taskId).update(
      {'id': taskId},
    );
  }

  Future _deleteTasks({required String id}) async{
    var collection = FirebaseFirestore.instance.collection('list');
    collection.doc(id).delete().then((_) => print('Deleted')).catchError((error) => print('Delete failed: $error'));

  }

}
