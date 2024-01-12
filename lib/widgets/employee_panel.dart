import 'package:flutter/material.dart';

import '../models/employee_model.dart';
import '../services/sql_data_retriever_admin.dart';
import '../services/utils.dart';
import 'add_employee_dialog.dart';

class EmployeePanel extends StatefulWidget {
  const EmployeePanel({super.key});

  @override
  State<EmployeePanel> createState() => _EmployeePanelState();
}

class _EmployeePanelState extends State<EmployeePanel> {
  late List<EmployeeModel> employees;
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  bool isLoading = true;

  Future<void> fetchData() async {
    employees = await sqlDataRetrieverAdmin.getAllEmployees();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'Employee Panel',
                      style: TextStyle(fontSize: 32),
                    ),
                    TextButton(
                      onPressed: () async {
                        final EmployeeModel? newEmployee = await showDialog<EmployeeModel>(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddEmployeeDialog();
                            });
                        if (newEmployee != null) {
                          setState(() {
                            employees.add(newEmployee);
                          });
                        }
                      },
                      style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: EmployeeModel.titles
                            .map(
                              (Map<String, dynamic> title) => DataColumn(
                                label: Text(title['field'] as String),
                                numeric: title['numeric'] as bool,
                              ),
                            )
                            .toList(),
                        rows: employees.map((EmployeeModel client) {
                          final List<Object> cells = <Object>[
                            client.name,
                            client.username,
                            client.salary,
                            client.hoursMonthly,
                            client.expirationDate,
                          ];
                          return DataRow(
                            cells: Utils.modelBuilderRows(
                              cells,
                              (int index, Object cell) {
                                return DataCell(
                                  Text('$cell'),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
