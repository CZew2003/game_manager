import 'package:flutter/material.dart';

import '../models/champion_panel_model.dart';
import '../services/utils.dart';
import 'dialog_edit_client.dart';

class ChampionPanel extends StatelessWidget {
  const ChampionPanel({
    super.key,
    required this.champions,
    required this.changeState,
  });

  final List<ChampionPanelModel> champions;
  final void Function(double?, int, ChampionPanelModel) changeState;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: ChampionPanelModel.titles
                .map(
                  (Map<String, dynamic> title) => DataColumn(
                    label: Text(title['field'] as String),
                    numeric: title['numeric'] as bool,
                  ),
                )
                .toList(),
            rows: champions.map((ChampionPanelModel champion) {
              final List<Object> cells = <Object>[
                champion.name,
                champion.health,
                champion.mana,
                champion.manaType,
                champion.armor,
                champion.magicResist,
                champion.movementSpeed,
                champion.healthRegen,
                champion.damage,
                champion.attackSpeed,
                champion.fullPrice,
                champion.shardPrice,
                champion.disenchantPrice,
              ];
              return DataRow(
                cells: Utils.modelBuilderRows(
                  cells,
                  (int index, Object cell) {
                    final bool editable = ChampionPanelModel.titles[index]['numeric'] == true;
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
                                    title: ChampionPanelModel.titles[index]['field'] as String,
                                    initialValue: '$cell',
                                  );
                                },
                              );
                              changeState(value, index, champion);
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
