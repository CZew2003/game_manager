import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/snack_bar.dart';
import '../models/employee_model.dart';
import '../services/sql_data_retriever_admin.dart';
import 'text_field_login.dart';

class AddEmployeeDialog extends StatefulWidget {
  const AddEmployeeDialog({super.key});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final TextEditingController controllerClientName = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerSalary = TextEditingController();
  final TextEditingController controllerHoursMonthly = TextEditingController();
  DateTime day = DateTime.now();
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();

  @override
  void dispose() {
    controllerClientName.dispose();
    controllerSalary.dispose();
    controllerName.dispose();
    controllerHoursMonthly.dispose();
    super.dispose();
  }

  Future<void> onPressed() async {
    final EmployeeModel employeeModel = EmployeeModel(
      name: controllerName.text,
      username: controllerClientName.text,
      salary: controllerSalary.text,
      hoursMonthly: int.parse(controllerHoursMonthly.text),
      expirationDate: '${day.year}-${day.month}-${day.day}',
    );
    await sqlDataRetrieverAdmin
        .createEmployee(
      employeeModel.name,
      employeeModel.username,
      int.parse(employeeModel.salary),
      employeeModel.hoursMonthly,
      '${day.year}-${day.month}-${day.day}',
    )
        .then((_) {
      Navigator.pop(context, employeeModel);
      showSnackBar(context, 'Employee Added');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Padding(
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
                    TextFieldLogin(controller: controllerClientName, hintText: 'Client Name', hideText: false),
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
                                      height: 450,
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
                                              focusedDay: selectedDay,
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
                  onPressed: onPressed,
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
