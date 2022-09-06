import 'package:security_wanyu/model/individual_notification.dart';

class IndividualNotificationTabModel {
  final bool? loading;
  final bool? unlocked;
  final List<IndividualNotification>? individualNotifications;
  List<IndividualNotification>? get pinnedIndividualNotifications =>
      individualNotifications!.where((ino) => ino.pinned!).toList();
  IndividualNotificationTabModel({
    this.loading,
    this.unlocked,
    this.individualNotifications,
  });

  IndividualNotificationTabModel copyWith({
    bool? loading,
    bool? unlocked,
    List<IndividualNotification>? individualNotifications,
  }) {
    return IndividualNotificationTabModel(
      loading: loading ?? this.loading,
      unlocked: unlocked ?? this.unlocked,
      individualNotifications:
          individualNotifications ?? this.individualNotifications,
    );
  }
}
