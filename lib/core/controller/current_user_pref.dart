import 'dart:developer';

import 'package:bashasagar/core/models/current_user_model.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserPref {
  static const _TOKEN = "TOKEN";
  static const _NAME = "NAME";
  static const _MOBILE = "MOBILE";
  static const _PASSWORD = "PASSWORD";
  static const _APPLANG = "APPLANG";

  static Future<void> setUserData(CurrentUserModel userModel) async {
    // log("name is :=${userModel.name}");
    final existingData = await getUserData;
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_TOKEN, userModel.token ?? existingData.token ?? '');
    await pref.setString(_NAME, userModel.name ?? existingData.name ?? '');
    await pref.setString(
      _MOBILE,
      userModel.mobile ?? existingData.mobile ?? '',
    );
    await pref.setString(
      _PASSWORD,
      userModel.password ?? existingData.password ?? '',
    );
    await pref.setString(
      _APPLANG,
      userModel.uiLangId ?? existingData.uiLangId ?? '',
    );
  }

  static Future<void> clearPref() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_TOKEN);
    await pref.remove(_NAME);
    await pref.remove(_MOBILE);
    await pref.remove(_PASSWORD);
    await pref.remove(_APPLANG);
  }

  static Future<CurrentUserModel> get getUserData async {
    final pref = await SharedPreferences.getInstance();

    final token = pref.getString(_TOKEN);
    final name = pref.getString(_NAME);
    final mobile = pref.getString(_MOBILE);
    final pasword = pref.getString(_PASSWORD);
    final appLang = pref.getString(_APPLANG);

    return CurrentUserModel(
      uiLangId: appLang ?? '',
      mobile: mobile ?? '',
      name: name ?? '',
      password: pasword ?? '',
      token: token ?? '',
    );
  }
}
