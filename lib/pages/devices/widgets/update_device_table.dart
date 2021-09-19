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
class DeviceUpdateTable extends StatelessWidget {
  final Function toggleViewDevice;
  final String deviceID;
  DeviceUpdateTable({this.toggleViewDevice, this.deviceID});
  @override
  Widget build(BuildContext context) {
    final device_list = Provider.of<List<Device>>(context) ?? [];
    Device device;
    for (int i = 0; i < device_list.length; i++) {
      if (device_list[i].id == deviceID) device = device_list[i];
    }
    print(deviceID);
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
      child: Column(
        children: [
          DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: [
              DataColumn2(
                label: Text("Type"),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Date'),
              ),
              DataColumn(label: Text('Just a random nr for now')),
              // DataColumn(
              //   label: Text('Rating'),
              // ),
              // DataColumn(
              //   label: Text('Action'),
              // ),
            ],
            rows: List<DataRow>.generate(1, (index) {
              List event_list = device_list[index].event_list;

              return DataRow(
                cells: [
                  DataCell(CustomText(text: 'Event type'),
                      onTap: () => toggleViewDevice('')),
                  DataCell(CustomText(text: 'Event date'), onTap: () => {}),
                  DataCell(CustomText(text: 'a random number for now'),
                      onTap: () =>
                          {}), // should be the number of events that day
                ],
              );
            }),
          ),
          // TextButton(
          //   onPressed: toggleViewDevice(deviceID),
          //   child: Text('View all devices'),
          // ),
        ],
      ),
    );
  }
}
