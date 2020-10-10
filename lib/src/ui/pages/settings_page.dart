import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skintel/src/app.dart';
import 'package:skintel/src/data/skin_model.dart';
import 'package:skintel/src/ui/style.dart';
import 'package:skintel/src/ui/widgets/skin_color_circle.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SkinColorModel skinColorModel;

  @override
  Widget build(BuildContext context) {
    //UserModel userModel = Provider.of<UserModel>(context);
    skinColorModel = Provider.of<SkinColorModel>(context);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    children: [
                      Text(
                        "Skintel",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.only(top: 60),
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
            /*   Padding(
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
                )), */
            /*   Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12.0),
              child: Text("Skin",
                  style: TextStyle(
                      fontFamily: kFontFamilyBold, color: Colors.black)),
            ), */
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Complexion",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                  trailing: _complexionDropdown(),
                )),
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  trailing: _skinTypeDropdown(),
                  title: Text("Skin Type",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                )),
            Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  trailing: _hoursOutdoorsDropdown(),
                  title: Text("Hours Outdoors",
                      style: TextStyle(fontFamily: kFontFamilyNormal)),
                )),
          ],
        ),
      ],
    );
  }

  _hoursOutdoorsDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton(
        value: skinColorModel.hoursOutdoors.toString(),
        items: [
          DropdownMenuItem(
              onTap: () => skinColorModel.updateHoursOutdoors(1),
              value: "1",
              child: Text(
                "1",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateHoursOutdoors(2),
              value: "2",
              child: Text(
                "2",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateHoursOutdoors(3),
              value: "3",
              child: Text(
                "3",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateHoursOutdoors(4),
              value: "4",
              child: Text(
                "4",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateHoursOutdoors(5),
              value: "5",
              child: Text(
                "5+",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
        ],
        onChanged: (value) {},
      ),
    );
  }

  _skinTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton(
        value: determineSkinTypeText(skinColorModel.skinTypeIndex),
        items: [
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinTypeIndex(0),
              value: "Acne and Dry",
              child: Text(
                "Acne and Dry",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinTypeIndex(1),
              value: "Acne and Oily",
              child: Text(
                "Acne and Oily",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinTypeIndex(2),
              value: "No Acne and Dry",
              child: Text(
                "No Acne and Dry",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinTypeIndex(3),
              value: "No Acne and Oily",
              child: Text(
                "No Acne and Oily",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinTypeIndex(4),
              value: "No Acne",
              child: Text(
                "No Acne",
                style: TextStyle(fontFamily: kFontFamilyNormal),
              )),
        ],
        onChanged: (value) {},
      ),
    );
  }

  _complexionDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton(
        value: determineSkinText(skinColorModel.skinColorIndex),
        items: [
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinColorIndex(0),
              value: "Very Fair",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          "Very Fair",
                          style: TextStyle(fontFamily: kFontFamilyBold),
                        ),
                      ),
                      SkinColorCircle(
                        skinColorIndex: 0,
                        selected: false,
                        updateSkinColorForParent: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      determineSkinDescription(0),
                      style: TextStyle(
                          fontFamily: kFontFamilyNormal, fontSize: 10),
                    ),
                  )
                ],
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinColorIndex(1),
              value: "Fair",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          "Fair",
                          style: TextStyle(fontFamily: kFontFamilyBold),
                        ),
                      ),
                      SkinColorCircle(
                        skinColorIndex: 1,
                        selected: false,
                        updateSkinColorForParent: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      determineSkinDescription(1),
                      style: TextStyle(
                          fontFamily: kFontFamilyNormal, fontSize: 10),
                    ),
                  )
                ],
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinColorIndex(2),
              value: "Medium",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          "Medium",
                          style: TextStyle(fontFamily: kFontFamilyBold),
                        ),
                      ),
                      SkinColorCircle(
                        skinColorIndex: 2,
                        selected: false,
                        updateSkinColorForParent: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      determineSkinDescription(2),
                      style: TextStyle(
                          fontFamily: kFontFamilyNormal, fontSize: 10),
                    ),
                  )
                ],
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinColorIndex(3),
              value: "Olive",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          "Olive",
                          style: TextStyle(fontFamily: kFontFamilyBold),
                        ),
                      ),
                      SkinColorCircle(
                        skinColorIndex: 3,
                        selected: false,
                        updateSkinColorForParent: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      determineSkinDescription(3),
                      style: TextStyle(
                          fontFamily: kFontFamilyNormal, fontSize: 10),
                    ),
                  )
                ],
              )),
          DropdownMenuItem(
              onTap: () => skinColorModel.updateSkinColorIndex(4),
              value: "Dark",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          "Dark",
                          style: TextStyle(fontFamily: kFontFamilyBold),
                        ),
                      ),
                      SkinColorCircle(
                        skinColorIndex: 4,
                        selected: false,
                        updateSkinColorForParent: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      determineSkinDescription(4),
                      style: TextStyle(
                          fontFamily: kFontFamilyNormal, fontSize: 10),
                    ),
                  )
                ],
              ))
        ],
        onChanged: (value) {},
      ),
    );
  }
}

String determineSkinTypeText(int index) {
  switch (index) {
    case 0:
      return "Acne and Dry";
      break;
    case 1:
      return "Acne and Oily";
      break;
    case 2:
      return "No Acne and Dry";
      break;
    case 3:
      return "No Acne and Oily";
      break;
    case 4:
      return "No Acne";
      break;
    default:
      return "No Acne";
  }
}
