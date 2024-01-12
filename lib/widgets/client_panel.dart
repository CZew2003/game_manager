import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/client_model.dart';
import '../models/client_panel_model.dart';
import '../services/sql_data_retriever_admin.dart';
import '../services/utils.dart';
import 'dialog_edit_client.dart';

class ClientPanel extends StatefulWidget {
  const ClientPanel({
    super.key,
    required this.selected,
    required this.onTap,
  });
  final bool selected;
  final void Function() onTap;

  @override
  State<ClientPanel> createState() => _ClientPanelState();
}

class _ClientPanelState extends State<ClientPanel> {
  late List<ClientPanelModel> clients;
  SqlDataRetrieverAdmin sqlDataRetrieverAdmin = SqlDataRetrieverAdmin();
  bool isLoading = true;

  Future<void> fetchData() async {
    clients = await sqlDataRetrieverAdmin.getClientsPanel();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: widget.selected ? 4 : 1,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: AnimatedContainer(
            color: widget.selected ? Colors.blue[100] : Colors.transparent,
            duration: const Duration(
              milliseconds: 500,
            ),
            child: Builder(
              builder: (BuildContext context) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!widget.selected) {
                  return const Center(child: Text('Click to open Clients Panel'));
                }
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Clients Panel',
                          style: TextStyle(fontSize: 32),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: ClientPanelModel.titles
                                    .map(
                                      (Map<String, dynamic> title) => DataColumn(
                                        label: Text(title['field'] as String),
                                        numeric: title['numeric'] as bool,
                                      ),
                                    )
                                    .toList(),
                                rows: clients.map((ClientPanelModel client) {
                                  final List<Object> cells = <Object>[
                                    client.username,
                                    client.password,
                                    client.rank,
                                    client.region,
                                    client.blueEssence,
                                    client.orangeEssence,
                                    client.riotPoints,
                                  ];
                                  return DataRow(
                                    cells: Utils.modelBuilderRows(cells, (int index, Object cell) {
                                      if (ClientPanelModel.titles[index]['numeric'] == false &&
                                          (ClientPanelModel.titles[index]['role'] as Role).index >
                                              context.watch<ClientModel>().role.index) {
                                        return DataCell(
                                          Text(
                                            '*' * cell.toString().length,
                                          ),
                                        );
                                      }
                                      final bool editable = ClientPanelModel.titles[index]['numeric'] == true &&
                                          (ClientPanelModel.titles[index]['role'] as Role).index <=
                                              context.watch<ClientModel>().role.index;
                                      return DataCell(
                                        Text('$cell'),
                                        showEditIcon: editable,
                                        onTap: !editable
                                            ? null
                                            : () async {
                                                final double? value = await showDialog<double>(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return DialogEditClient(
                                                      title: ClientPanelModel.titles[index]['field'] as String,
                                                      initialValue: '$cell',
                                                    );
                                                  },
                                                );
                                                setState(
                                                  () {
                                                    clients[clients.indexOf(client)] = client.copyWith(
                                                      blueEssence: index == 4 ? value!.toInt() : client.blueEssence,
                                                      orangeEssence: index == 5 ? value!.toInt() : client.orangeEssence,
                                                      riotPoints: index == 6 ? value!.toInt() : client.riotPoints,
                                                    );
                                                  },
                                                );
                                              },
                                      );
                                    }),
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
            ),
          ),
        ),
      ),
    );
  }
}
