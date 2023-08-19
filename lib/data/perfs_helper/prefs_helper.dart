import 'dart:convert';

import 'package:flutter_movies_app/data/entities/user_model.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  final SharedPreferences prefs;

  PrefsHelper(this.prefs);

  String get requestToken => prefs.getString(REQUEST_TOKEN) ?? "";

  String get sessionId => prefs.getString(SESSION_ID) ?? "";

  String get userDetails => prefs.getString(USER) ?? "";

  saveRequestToken(String requestToken) async {
    await prefs.setString(REQUEST_TOKEN, requestToken);
  }

  saveSessionId(String sessionId) async {
    await prefs.setString(SESSION_ID, sessionId);
  }

  saveUserDetails(UserModel user) async {
    await prefs.setString(USER, jsonEncode(user.toMap()));
  }
}
