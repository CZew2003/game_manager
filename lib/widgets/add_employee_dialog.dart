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
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Add Employee',
              style: TextStyle(fontSize: 32),
            ),
            Container(
              width: 400,
              child: Column(
                children: <Widget>[
                  TextFieldLogin(controller: controllerIdClient, hintText: 'Client ID', hideText: false),
                  TextFieldLogin(controller: controllerName, hintText: 'Admin Name', hideText: false),
                  TextFieldLogin(controller: controllerSalary, hintText: 'Salary', hideText: false),
                  TextFieldLogin(controller: controllerHoursMonthly, hintText: 'Hours Monthly', hideText: false),
                  FilledButton.tonal(
                    onPressed: () {
                      DateTime day = DateTime.now();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: SizedBox(
                            height: 400,
                            width: 450,
                            child: TableCalendar<dynamic>(
                              locale: 'en_US',
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: day,
                              onDaySelected: (DateTime a, DateTime b) {
                                print(a);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Add Expiration Date',
                    ),
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
    );
  }
}
