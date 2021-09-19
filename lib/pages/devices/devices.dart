import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/database.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/pages/devices/widgets/devices_table.dart';
import 'package:flutter_web_dashboard/pages/devices/widgets/input_sheet.dart';
import 'package:flutter_web_dashboard/pages/devices/widgets/update_device_table.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_dashboard/models/device.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  String device_to_see = '';
  void toggleViewDevice(String deviceID) {
    setState(() => device_to_see = deviceID);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    String uid = user.uid;

    void showInputSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: InputSheet(),
            );
          });
    }

    print(device_to_see);
    return StreamProvider<List<Device>>.value(
      value: DatabaseService(uid: uid).devices,
      initialData: null,
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  device_to_see == ''
                      ? DevicesTable(toggleViewDevice: toggleViewDevice)
                      : DeviceUpdateTable(
                          toggleViewDevice: toggleViewDevice,
                          deviceID: device_to_see),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showInputSheet(),
          backgroundColor: active,
          tooltip: 'Add a new device',
        ),
      ),
    );
  }
}
