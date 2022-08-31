import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/enum/sign_in_results.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/punch_card_record.dart';
import 'package:http_parser/http_parser.dart';
import 'package:security_wanyu/model/submit_form_record.dart';

class EtunAPI {
  static String baseUrl = 'https://service.etun.com.tw/app_api/runner.php';
  //登入。
  static Future<Map<String, dynamic>> signIn(
      {required String memberAccount, required String memberPassword}) async {
    Uri url = Uri.parse(
        '$baseUrl?op=signIn&member_account=$memberAccount&member_password=$memberPassword');
    try {
      http.Response response = await http.get(url);
      bool success = json.decode(response.body)['success'];
      if (success) {
        return {
          'signInResult': SignInResults.success,
          'member': Member.fromData(json.decode(response.body)['member']),
        };
      } else {
        String code = json.decode(response.body)['code'];
        if (code == 'wrong-password') {
          return {
            'signInResult': SignInResults.wrongPassword,
          };
        }
        return {
          'signInResult': SignInResults.error,
        };
      }
    } catch (e) {
      return {
        'signInResult': SignInResults.error,
      };
    }
  }

  //打卡。
  static Future<bool> punchCard({
    required PunchCards type,
    required Member member,
    DateTime? dateTime,
    PunchCards? makeupType,
    String? place,
    double? lat,
    double? lng,
  }) async {
    try {
      Uri url = Uri.parse('$baseUrl?op=punchCard');
      PunchCardRecord punchCardRecord = PunchCardRecord(
        memberId: member.memberId,
        memberSN: member.memberSN,
        memberName: member.memberName,
        dateTime: dateTime,
        punchCardType: type,
        makeupType: makeupType,
        place: place,
        lat: lat,
        lng: lng,
      );
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: punchCardRecord.toJSON(),
      );
      bool success = json.decode(response.body)['success'];
      return success;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> submitForm({
    required List<int> formData,
    required SubmitFormRecord formRecord,
  }) async {
    try {
      Uri url = Uri.parse('$baseUrl?op=uploadForm');
      http.MultipartRequest request = http.MultipartRequest('POST', url)
        ..fields.addAll(formRecord.toMap())
        ..files.add(
          http.MultipartFile.fromBytes(
            'leaveForm',
            formData,
            filename: 'leaveForm.docx',
            contentType: MediaType.parse(
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
          ),
        );
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      bool success = json.decode(response.body)['success'];
      return success;
    } catch (e) {
      return false;
    }
  }
}
