import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/utils/app_var.dart';

class SessionManager {
  static const _cachedUserKey = "cachedUser";

  static Future<void> hydrateFromPrefs() async {
    final pref = await SharedPreferences.getInstance();

    userId = pref.getString("userId") ?? "";
    userEmail = pref.getString("userEmail") ?? "";
    userEmail2 = pref.getString("userEmail2") ?? "";
    userNickName = pref.getString("userNickName") ?? "";
    userNickName2 = pref.getString("userNickName2") ?? "NickName";
    userName = pref.getString("userName") ?? "";
    userName2 = pref.getString("userName2") ?? "Name";
    userGender = pref.getString("userGender") ?? "";
    userGender2 = pref.getString("userGender2") ?? "Gender";
    userCountry = pref.getString("userCountry") ?? "";
    userCountry2 = pref.getString("userCountry2") ?? "Country";
    userPhoneNumber = pref.getString("userPhoneNumber") ?? "";
    loginType = pref.getInt("loginType") ?? 0;
    isMovieFavorite = pref.getBool("isMovieFavorite") ?? false;
    isPremiumPlan = pref.getBool("isPremiumPlan") ?? false;
    isMovieDownload = pref.getBool("isMovieDownload") ?? false;
    userProfileImage = pref.getString("userProfileImage") ?? userProfileImage;
    userImage = pref.getString("userImage") ?? "";
    downloadedMovie.value = pref.getStringList("DownloadList") ?? [];
  }

  static bool hasCompletedProfile(Map<String, dynamic>? user) {
    if (user == null) return false;

    final fullName = (user["fullName"] ?? "").toString().trim();
    final mobileNumber = (user["mobileNumber"] ?? "").toString().trim();
    final gender = (user["gender"] ?? "").toString().trim();

    return fullName.isNotEmpty && mobileNumber.isNotEmpty && gender.isNotEmpty;
  }

  static Future<void> persistUserSession(
    Map<String, dynamic> user, {
    bool isLoggedIn = true,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final resolvedLoginType = user["loginType"] is int
        ? user["loginType"] as int
        : int.tryParse((user["loginType"] ?? "0").toString()) ?? 0;

    await pref.setBool("isLogin", isLoggedIn);
    await pref.setString("userId", (user["_id"] ?? "").toString());
    await pref.setString("userEmail", (user["email"] ?? "").toString());
    await pref.setString("userEmail2", (user["email"] ?? "").toString());
    await pref.setString("userName", (user["fullName"] ?? "").toString());
    await pref.setString("userName2", (user["fullName"] ?? "").toString());
    await pref.setString("userNickName", (user["nickName"] ?? "").toString());
    await pref.setString("userNickName2", (user["nickName"] ?? "").toString());
    await pref.setString("userGender", (user["gender"] ?? "").toString());
    await pref.setString("userGender2", (user["gender"] ?? "").toString());
    await pref.setString("userCountry", (user["country"] ?? "").toString());
    await pref.setString("userCountry2", (user["country"] ?? "").toString());
    await pref.setString(
      "userPhoneNumber",
      (user["mobileNumber"] ?? "").toString(),
    );
    await pref.setString("userImage", (user["image"] ?? "").toString());
    await pref.setString(
      "userProfileImage",
      (user["image"] ?? userProfileImage).toString(),
    );
    await pref.setBool("isPremiumPlan", user["isPremiumPlan"] == true);
    await pref.setInt("loginType", resolvedLoginType);
    await pref.setString(_cachedUserKey, jsonEncode(user));

    userId = (user["_id"] ?? "").toString();
    userEmail = (user["email"] ?? "").toString();
    userEmail2 = userEmail;
    userName = (user["fullName"] ?? "").toString();
    userName2 = userName;
    userNickName = (user["nickName"] ?? "").toString();
    userNickName2 = userNickName;
    userGender = (user["gender"] ?? "").toString();
    userGender2 = userGender;
    userCountry = (user["country"] ?? "").toString();
    userCountry2 = userCountry;
    userPhoneNumber = (user["mobileNumber"] ?? "").toString();
    userImage = (user["image"] ?? "").toString();
    userProfileImage = (user["image"] ?? userProfileImage).toString();
    isPremiumPlan = user["isPremiumPlan"] == true;
    loginType = resolvedLoginType;
  }

  static Future<Map<String, dynamic>?> getCachedUser() async {
    final pref = await SharedPreferences.getInstance();
    final raw = pref.getString(_cachedUserKey);
    if (raw == null || raw.isEmpty) return null;

    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearSession() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("isLogin", false);
    await pref.remove("userId");
    await pref.remove("userEmail");
    await pref.remove("userEmail2");
    await pref.remove("userName");
    await pref.remove("userName2");
    await pref.remove("userNickName");
    await pref.remove("userNickName2");
    await pref.remove("userGender");
    await pref.remove("userGender2");
    await pref.remove("userCountry");
    await pref.remove("userCountry2");
    await pref.remove("userPhoneNumber");
    await pref.remove("userProfileImage");
    await pref.remove("userImage");
    await pref.remove("isPremiumPlan");
    await pref.remove("loginType");
    await pref.remove(_cachedUserKey);

    userId = "";
    userEmail = "";
    userEmail2 = "";
    userName = "";
    userName2 = "";
    userNickName = "";
    userNickName2 = "";
    userGender = "";
    userGender2 = "";
    userCountry = "";
    userCountry2 = "";
    userPhoneNumber = "";
    userImage = "";
    isPremiumPlan = false;
    loginType = 0;
  }
}
