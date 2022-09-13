import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/enum/sign_in_results.dart';
import 'package:security_wanyu/model/company_announcement.dart';
import 'package:security_wanyu/model/individual_notification.dart';
import 'package:security_wanyu/model/marquee_announcement.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/punch_card_record.dart';
import 'package:http_parser/http_parser.dart';
import 'package:security_wanyu/model/signable_document.dart';
import 'package:security_wanyu/model/submit_form_record.dart';
import 'package:security_wanyu/model/submit_onboard_document_record.dart';

class EtunAPI {
  EtunAPI._constructor();
  static final EtunAPI instance = EtunAPI._constructor();

  final String _baseUrl = 'https://service.etun.com.tw/app_api/runner.php';
  //登入。
  Future<Map<String, dynamic>> signIn(
      {required String memberAccount, required String memberPassword}) async {
    try {
      Uri url = Uri.parse(
          '$_baseUrl?op=signIn&member_account=$memberAccount&member_password=$memberPassword');
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
  Future<bool> punchCard({
    required PunchCards type,
    required Member member,
    DateTime? dateTime,
    PunchCards? makeupType,
    String? place,
    double? lat,
    double? lng,
  }) async {
    try {
      Uri url = Uri.parse('$_baseUrl?op=punchCard');
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

  //提交表單。
  Future<bool> submitForm({
    required List<int> formData,
    required SubmitFormRecord formRecord,
  }) async {
    try {
      Uri url = Uri.parse('$_baseUrl?op=submitForm');
      http.MultipartRequest request = http.MultipartRequest('POST', url)
        ..fields['form_record'] = formRecord.toJSON()
        ..files.add(
          http.MultipartFile.fromBytes(
            'form',
            formData,
            filename: 'form.docx',
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

  //獲得跑馬燈公告。
  Future<MarqueeAnnouncement> getMarqueeAnnouncement() async {
    Uri url = Uri.parse('$_baseUrl?op=getMarqueeAnnouncement');
    http.Response response = await http.get(url);
    var body = json.decode(response.body);
    bool success = body['success'];
    if (success) {
      final data = body['marqueeAnnouncement'] != null
          ? json.decode(body['marqueeAnnouncement'])
          : null;
      if (data != null) {
        MarqueeAnnouncement marqueeAnnouncement =
            MarqueeAnnouncement.fromData(data);
        return marqueeAnnouncement;
      }
      return MarqueeAnnouncement(content: '目前尚無公告');
    } else {
      throw Exception('Something went wrong.');
    }
  }

  //獲得公司公告。
  Future<List<CompanyAnnouncement>> getCompanyAnnouncements() async {
    Uri url = Uri.parse('$_baseUrl?op=getCompanyAnnouncements');
    http.Response response = await http.get(url);
    var body = json.decode(response.body);
    bool success = body['success'];
    if (success) {
      List<CompanyAnnouncement> companyAnnouncements =
          (json.decode(body['companyAnnouncements']) as List)
              .map((data) => CompanyAnnouncement.fromData(data))
              .toList();
      return companyAnnouncements;
    } else {
      throw Exception('Something went wrong.');
    }
  }

  //獲得個人通知。
  Future<List<IndividualNotification>> getIndividualNotifications(
      {required int memberId}) async {
    Uri url = Uri.parse(
        '$_baseUrl?op=getIndividualNotifications&patrol_member_id=$memberId');
    http.Response response = await http.get(url);
    var body = json.decode(response.body);
    bool success = body['success'];
    if (success) {
      List<IndividualNotification> individualNotifications =
          (json.decode(body['individualNotifications']) as List)
              .map((data) => IndividualNotification.fromData(data))
              .toList();
      return individualNotifications;
    } else {
      throw Exception('Something went wrong.');
    }
  }

  //獲得待簽署文件。
  Future<List<SignableDocument>> getSignableDocuments() async {
    Uri url = Uri.parse('$_baseUrl?op=getSignableDocuments');
    http.Response response = await http.get(url);
    var body = json.decode(response.body);
    bool success = body['success'];
    if (success) {
      List<SignableDocument> signableDocuments =
          (json.decode(body['signableDocuments']) as List)
              .map((data) => SignableDocument.fromData(data))
              .toList();
      return signableDocuments;
    } else {
      throw Exception('Something went wrong.');
    }
  }

  //標示個人通知為已讀。
  Future<void> markIndividualNotificationAsSeen(
      {required int notificationId}) async {
    Uri url = Uri.parse('$_baseUrl?op=markIndividualNotificationAsSeen');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'notification_id': notificationId.toString()},
    );
    bool success = json.decode(response.body)['success'];
    if (!success) {
      throw Exception('Something went wrong.');
    }
  }

  //標示公司公告為已讀。
  Future<void> markCompanyAnnouncementAsSeen({
    required int announcementId,
    required int memberId,
  }) async {
    Uri url = Uri.parse('$_baseUrl?op=markCompanyAnnouncementAsSeen');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'announcement_id': announcementId.toString(),
        'patrol_member_id': memberId.toString(),
      },
    );
    bool success = json.decode(response.body)['success'];
    if (!success) {
      throw Exception('Something went wrong.');
    }
  }

  //獲得最近50筆已讀的公司公告id。
  Future<List<int>> getRecentSeenCompanyAnnouncementIds(
      {required int memberId}) async {
    Uri url = Uri.parse(
        '$_baseUrl?op=getRecentSeenCompanyAnnouncementIds&patrol_member_id=$memberId');
    http.Response response = await http.get(url);
    var body = json.decode(response.body);
    bool success = body['success'];
    if (success) {
      List<int> recentSeenCompanyAnnouncementIds =
          (json.decode(body['recentSeenCompanyAnnouncementIds']) as List)
              .map((rsca) => rsca as int)
              .toList();
      return recentSeenCompanyAnnouncementIds;
    } else {
      throw Exception('Something went wrong.');
    }
  }

  //提交辦理入職的文件。
  Future<bool> submitOnboardDocument({
    required List<List<int>> documentImage,
    required SubmitOnboardDocumentRecord onboardDocumentRecord,
  }) async {
    try {
      Uri url = Uri.parse('$_baseUrl?op=submitOnboardDocument');
      List<http.MultipartFile> files = [];
      for (int i = 0; i < documentImage.length; i++) {
        files.add(http.MultipartFile.fromBytes(
          'onboardDocumentImages[]',
          documentImage[i],
          filename: 'onboardDocumentImage${i + 1}.jpeg',
          contentType: MediaType.parse('image/jpeg'),
        ));
      }
      http.MultipartRequest request = http.MultipartRequest('POST', url)
        ..fields['onboard_document_record'] = onboardDocumentRecord.toJSON()
        ..files.addAll(files);
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      bool success = json.decode(response.body)['success'];
      return success;
    } catch (e) {
      return false;
    }
  }
}
