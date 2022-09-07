import 'package:security_wanyu/model/company_announcement_tab_model.dart';
import 'package:security_wanyu/model/individual_notification_tab_model.dart';

class AnnouncementScreenModel {
  final CompanyAnnouncementTabModel? companyAnnouncementTab;
  final IndividualNotificationTabModel? individualNotificationTab;
  AnnouncementScreenModel({
    this.companyAnnouncementTab,
    this.individualNotificationTab,
  });

  AnnouncementScreenModel copyWith({
    CompanyAnnouncementTabModel? companyAnnouncementTab,
    IndividualNotificationTabModel? individualNotificationTab,
  }) {
    return AnnouncementScreenModel(
      companyAnnouncementTab:
          companyAnnouncementTab ?? this.companyAnnouncementTab,
      individualNotificationTab:
          individualNotificationTab ?? this.individualNotificationTab,
    );
  }
}
