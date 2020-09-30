import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skintel/src/data/user_model.dart';
import 'package:skintel/src/ui/style.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Row(
                    children: [
                      Text(
                        "Skintel",
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.wb_sunny),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: kFontFamilyBold,
                          fontSize: 40,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12.0),
              child: Text("Account",
                  style: TextStyle(
                      fontFamily: kFontFamilyBold, color: Colors.black)),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Email",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                  trailing: Text(userModel.user.email ?? '',
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12.0),
              child: Text("Push Notifications",
                  style: TextStyle(
                      fontFamily: kFontFamilyBold, color: Colors.black)),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("12 PM Sun Notification",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      userModel.user.sunNotification =
                          !userModel.user.sunNotification;
                      userModel.updateUser(userModel.user);
                    },
                    value: userModel.user.sunNotification,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12.0),
              child: Text("Skin",
                  style: TextStyle(
                      fontFamily: kFontFamilyBold, color: Colors.black)),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Complexion",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                )),
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Skin Color",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                )),
          ],
        ),
      ],
    );
  }
}
