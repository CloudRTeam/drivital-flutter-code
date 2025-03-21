import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return AuthenticationPage();
    } else {
      return SiteLayout();
    }
  }
}
