import 'package:flutter/material.dart';

import '../models/skins_panel_model.dart';
import '../services/utils.dart';
import 'dialog_edit_client.dart';

class SkinPanel extends StatelessWidget {
  const SkinPanel({
    super.key,
    required this.skins,
    required this.changeState,
  });

  final List<SkinPanelModel> skins;
  final void Function(double?, int, SkinPanelModel) changeState;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: SkinPanelModel.titles
                .map(
                  (Map<String, dynamic> title) => DataColumn(
                    label: Text(title['field'] as String),
                    numeric: title['numeric'] as bool,
                  ),
                )
                .toList(),
            rows: skins.map((SkinPanelModel skin) {
              final List<Object> cells = <Object>[
                skin.skinName,
                skin.championName,
                skin.fullPrice,
                skin.shardPrice,
                skin.disenchantPrice,
              ];
              return DataRow(
                cells: Utils.modelBuilderRows(
                  cells,
                  (int index, Object cell) {
                    final bool editable = SkinPanelModel.titles[index]['numeric'] == true;
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
                                    title: SkinPanelModel.titles[index]['field'] as String,
                                    initialValue: '$cell',
                                  );
                                },
                              );
                              changeState(value, index, skin);
                            },
                    );
                  },
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
