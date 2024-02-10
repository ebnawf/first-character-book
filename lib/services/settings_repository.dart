import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/input_dialog.dart';

class SettingsRepository {
  static Future<String> getUserName() async {
    final pref = await SharedPreferences.getInstance();
    String? userName = pref.getString('userName');
    if (userName != null) {
      return userName;
    } else {
      return "";
    }
  }

  static Future saveUserName(String userName) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString('userName', userName);
  }

  static Future<String> showInputNameDialoge(BuildContext context,
      {String initValue = ''}) async {
    String? result = await showDialog(
      context: context,
      builder: (context) => MyInputDialog(
        initialValue: initValue,
        hintText: 'أدخل إسمك هنا ',
        title: 'إدخال اسم المستخدم',
      ),
    );
    result ??= initValue; 
    saveUserName(result);
    return result;
  }

  static Future<String> getPackageName() async {
    var packageinfo = await PackageInfo.fromPlatform();
    return packageinfo.packageName;
  }
}
