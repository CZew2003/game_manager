import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'text_field_login.dart';

class AddEmployeeDialog extends StatefulWidget {
  const AddEmployeeDialog({super.key});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final TextEditingController controllerIdClient = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerSalary = TextEditingController();
  final TextEditingController controllerHoursMonthly = TextEditingController();
  final TextEditingController controllerExpirationDate = TextEditingController();
  DateTime day = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(
        builder: (context, setstate) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Add Employee',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                width: 400,
                child: Column(
                  children: <Widget>[
                    TextFieldLogin(controller: controllerIdClient, hintText: 'Client ID', hideText: false),
                    TextFieldLogin(controller: controllerName, hintText: 'Admin Name', hideText: false),
                    TextFieldLogin(controller: controllerSalary, hintText: 'Salary', hideText: false),
                    TextFieldLogin(controller: controllerHoursMonthly, hintText: 'Hours Monthly', hideText: false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FilledButton.tonal(
                          onPressed: () async {
                            final DateTime? finalDay = await showDialog<DateTime>(
                              context: context,
                              builder: (BuildContext context) {
                                DateTime selectedDay = DateTime.now();
                                return Dialog(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) => SizedBox(
                                      height: 400,
                                      width: 450,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: TableCalendar<dynamic>(
                                              locale: 'en_US',
                                              headerStyle:
                                                  const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                                              firstDay: DateTime.utc(2010, 10, 16),
                                              lastDay: DateTime.utc(2030, 3, 14),
                                              focusedDay: DateTime.now(),
                                              selectedDayPredicate: (DateTime day) => isSameDay(day, selectedDay),
                                              onDaySelected: (DateTime day, DateTime focusedDay) {
                                                setState(() {
                                                  selectedDay = day;
                                                });
                                              },
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, selectedDay);
                                            },
                                            child: const Text('Done'),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                            if (finalDay != null) {
                              setState(() {
                                day = finalDay;
                              });
                            }
                          },
                          child: const Text(
                            'Add Expiration Date',
                          ),
                        ),
                        Text('${day.year}-${day.month}-${day.day}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
