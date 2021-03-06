import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_admin/HR_app/Screens/CompanyInformation/company_information.dart';
import 'package:hr_admin/HR_app/Screens/ForgetPassword/screen_forget_password.dart';
import 'package:hr_admin/HR_app/Screens/navigationbar.dart';
import 'package:hr_admin/HR_app/constants.dart';

// ignore: camel_case_types
class Signin_Pg1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //--------------------stacked container for styling------------------
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.17,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(150),
                ),
              ),
            ),
          ),
//--------------------------body-------------------------
          body(),
        ],
      ),
    );
  }
}

class body extends StatefulWidget {
  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool isvisible = false;
  TextEditingController _controller1 = new TextEditingController();

  TextEditingController _controller2 = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isvisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return MyBody(context);
  }

  Scaffold MyBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CircleAvatar(
                      radius: 140,
                      backgroundColor: Colors.transparent,
                      child: Image(image: AssetImage('assets/images/Frame.png')),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _controller1,
                      style: TextFieldTextStyle(),
                      decoration: TextFieldDecoration('User Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        final pattern = ('[a-zA-Z]+([\s][a-zA-Z]+)*');
                        final regExp = RegExp(pattern);
                        if (value.isEmpty) {
                          return null;
                        } else if (!regExp.hasMatch(value)) {
                          return 'Enter a Valid User Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // textInputAction: TextInputAction.none,
                      controller: _controller2,
                      style: TextFieldTextStyle(),
                      obscureText: !isvisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        // floatingLabelStyle: TextStyle(fontSize: 20),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },
                            icon: Icon(isvisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
          
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        // hintText: 'Password',
                        // hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey[300]),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey[300]),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return null;
                        } else if (value.contains(' ')) {
                          return 'Password can not contain blank Spaces';
                        } else if (value.length < 4) {
                          return 'Enter atleast 4 characters';
                        } else
                          return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                          },
                          child: Text('Forget Password?',
                              style: TextStyle(color: Colors.grey))),
                    ),
                  ],
                ),
                // SizedBox(height: 250),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompanyInformation()));
                        },
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                onPressed: () async {
                  if (_controller1.text.isNotEmpty &&
                      _controller2.text.isNotEmpty) {
                    if (_formkey.currentState.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _controller1.text,
                            password: _controller2.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationBar(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print("No User Found for that Email");
                          print("::::::::::::::::::::::::::::::::");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "No User Found for that Email",
                              ),
                            ),
                          );
                        } else if (e.code == 'wrong-password') {
                          print("Wrong Password Provided by User");
                          print("-----------------------------------");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Wrong Password Provided by User",
                              ),
                            ),
                          );
                        }
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Enter Email & Password",
                        ),
                      ),
                    );
                  }
                  // else{
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Enter email & password')),
                  //     );
                  // }
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Signin_scaffold()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
