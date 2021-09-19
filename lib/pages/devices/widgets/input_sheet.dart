import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/helpers/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';

class InputSheet extends StatefulWidget {
  InputSheet({Key key}) : super(key: key);
  @override
  _InputSheetState createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet> {
  final _formKey = GlobalKey<FormState>();
  String _deviceID = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final uid = user.uid;
    final DatabaseService db = DatabaseService(uid: uid);

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter the device ID' : null,
              onChanged: (val) => setState(() => _deviceID = val),
              decoration: InputDecoration(
                labelText: "Device ID",
                hintText: "device ID",
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: active,
                            padding: EdgeInsets.symmetric(vertical: 20)),
                        child: Text(
                          'Add device',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await db.addDevice(deviceId: _deviceID);
                            Navigator.pop(context);
                          }
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
