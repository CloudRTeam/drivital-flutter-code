import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/loading.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_dashboard/helpers/auth.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String deviceID = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                padding: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              child: Image.asset(
                                "assets/icons/drivital_logo.png",
                                width: 150,
                                height: 150,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text("Register",
                              style: GoogleFonts.roboto(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Welcome back to the admin panel.",
                            color: lightGrey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "abc@domain.com",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (val) => val.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "password",
                              hintText: "1234",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter the device ID' : null,
                            onChanged: (val) {
                              setState(() => deviceID = val);
                            },
                            decoration: InputDecoration(
                              labelText: "Device ID",
                              hintText: "device ID",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                print("send email");
                              },
                              child: Text("Forgot password?"))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, deviceID);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: active,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CustomText(
                            text: "Register",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: "Don't have an account yet? "),
                          TextSpan(
                            text: "Click here to login.",
                            style: TextStyle(color: Colors.lightGreen[600]),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.toggleView,
                          )
                        ]),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
