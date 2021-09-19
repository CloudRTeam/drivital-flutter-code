import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/controllers/menu_controller.dart';
import 'package:flutter_web_dashboard/controllers/navigation_controller.dart';
import 'package:flutter_web_dashboard/helpers/auth.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/wrapper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      initialData: null,
      child: GetMaterialApp(
          initialRoute: wrapperRoute,
          unknownRoute: GetPage(
              name: '/not-found',
              page: () => PageNotFound(),
              transition: Transition.fadeIn),
          getPages: [
            GetPage(
                name: rootRoute,
                page: () {
                  return SiteLayout();
                }),
            GetPage(
                name: authenticationPageRoute,
                page: () => AuthenticationPage()),
            GetPage(name: wrapperRoute, page: () => Wrapper()),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Drivital',
          theme: ThemeData(
            scaffoldBackgroundColor: light,
            textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            }),
            primarySwatch: Colors.green,
            // home: AuthenticationPage(),
          )),
    );
  }
}
