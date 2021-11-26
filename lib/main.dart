import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_admin/HR_app/Splash/splash.dart';
import 'package:hr_admin/HR_app/Theme.dart';
import 'package:hr_admin/HR_app/constants.dart';
import 'package:uuid/uuid.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget with ChangeNotifier {
  static ValueNotifier<bool> isdarkmode = ValueNotifier(false);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // var uuid = Uuid();
  String u;
  userIDgenerator() async {
    var userID;
    if (await getdata('userID') == "" || await getdata('userID') == null) {
      userID = Uuid().v4();
      print(userID);
      setdata('userID', userID);
    }
    print(userID);
  }

  @override
  void initState() {
    getdata('userID').then((value) => u = value);
    print(u);
    print('===================================================');
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  @override
  Widget build(BuildContext context) {
    userIDgenerator();
    
    return ValueListenableBuilder(
        valueListenable: MyApp.isdarkmode,
        builder: (context, value, _) {
          return FutureBuilder(
              future: _initialization,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return MaterialApp(
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    theme: darkmode == false
                        ? lightThemeData(context)
                        : darkThemeData(context),
                    // theme: lightThemeData(context),
                    // darkTheme: darkThemeData(context),
                    home: Splash(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}
// home: Signin_Pg1(),