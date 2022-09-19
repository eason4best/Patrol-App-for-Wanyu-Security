import 'package:security_wanyu/model/company_announcement_tab_model.dart';
import 'package:security_wanyu/model/individual_notification_tab_model.dart';
import 'package:security_wanyu/model/signable_document_tab_model.dart';

class AnnouncementScreenModel {
  final CompanyAnnouncementTabModel? companyAnnouncementTab;
  final IndividualNotificationTabModel? individualNotificationTab;
  final SignableDocumentTabModel? signableDocumentTab;
  final bool? hasInternetConnection;
  AnnouncementScreenModel({
    this.companyAnnouncementTab,
    this.individualNotificationTab,
    this.signableDocumentTab,
    this.hasInternetConnection,
  });

  AnnouncementScreenModel copyWith(
      {CompanyAnnouncementTabModel? companyAnnouncementTab,
      IndividualNotificationTabModel? individualNotificationTab,
      SignableDocumentTabModel? signableDocumentTab,
      bool? hasInternetConnection}) {
    return AnnouncementScreenModel(
      companyAnnouncementTab:
          companyAnnouncementTab ?? this.companyAnnouncementTab,
      individualNotificationTab:
          individualNotificationTab ?? this.individualNotificationTab,
      signableDocumentTab: signableDocumentTab ?? this.signableDocumentTab,
      hasInternetConnection:
          hasInternetConnection ?? this.hasInternetConnection,
    );
  }
}
