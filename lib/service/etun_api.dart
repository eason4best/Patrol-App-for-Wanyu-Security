import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:security_wanyu/enum/sign_in_results.dart';

class EtunAPI {
  static String baseUrl = 'https://service.etun.com.tw/app_api/runner.php';
  //登入。
  static Future<SignInResults> signIn(
      {required String memberAccount, required String memberPassword}) async {
    Uri url = Uri.parse(
        '$baseUrl?op=signIn&member_account=$memberAccount&member_password=$memberPassword');
    try {
      http.Response response = await http.get(url);
      bool result = json.decode(response.body)['success'];
      if (result) {
        return SignInResults.success;
      } else {
        String code = json.decode(response.body)['code'];
        if (code == 'wrong-password') {
          return SignInResults.wrongPassword;
        }
        return SignInResults.error;
      }
    } catch (_) {
      return SignInResults.error;
    }
  }
}
