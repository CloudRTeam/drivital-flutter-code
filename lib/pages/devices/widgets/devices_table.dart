import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/event.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_dashboard/models/device.dart';

/// Example without datasource
class DevicesTable extends StatelessWidget {
  final Function toggleViewDevice;
  DevicesTable({this.toggleViewDevice});
  @override
  Widget build(BuildContext context) {
    final device_list = Provider.of<List<Device>>(context) ?? [];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: [
          DataColumn2(
            label: Text("Name"),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text('Number of alerts'),
          ),
          DataColumn(label: Text('Number of alerts today')),
          // DataColumn(
          //   label: Text('Rating'),
          // ),
          // DataColumn(
          //   label: Text('Action'),
          // ),
        ],
        rows: List<DataRow>.generate(device_list.length, (index) {
          List<Event> event_list =
              EventTypeListFromEventList(device_list[index].event_list);
          DateTime now = DateTime.now();
          List<Event> today_event_list = [];
          for (Event event in event_list) {
            Duration diff = event.date.difference(now);
            if (diff.inDays <= 1) {
              today_event_list.add(event);
            }
          }
          return DataRow(
            cells: [
              DataCell(CustomText(text: device_list[index].name),
                  onTap: () => toggleViewDevice(device_list[index].id)),
              DataCell(CustomText(text: '${event_list.length}'),
                  onTap: () => toggleViewDevice(device_list[index].id)),
              DataCell(CustomText(text: '${today_event_list.length}'),
                  onTap: () => toggleViewDevice(device_list[index]
                      .id)), // should be the number of events that day
            ],
          );
        }),
      ),
    );
  }
}
