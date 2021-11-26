import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hr_admin/HR_app/Screens/Messages1/components/model.dart';
import 'package:hr_admin/HR_app/constants.dart';

class TextMessage extends StatelessWidget {
  TextMessage({Key key, this.message, this.index, this.userID})
      : super(key: key);
  final List message;
  final key = GlobalKey<FormState>();
  int index;
  String userID;
  // getuserID() async {
  //   userID = await getdata('userID');
  // }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.5,
      actionPane: SlidableBehindActionPane(),
      // secondaryActions: [
      //   Text(formatDate(message.date, [' ',hh,'.',nn]).toString())
      // ],
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            minWidth: MediaQuery.of(context).size.width * 0.2),
        padding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: message[index]['userID'] == userID //getdata('userID')
              ? Colors.blue
              : kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message[index]['body'],
          style: TextStyle(
            color: message[index]['userID'] == userID //getdata('userID')
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
      ),
    );
  }
}
