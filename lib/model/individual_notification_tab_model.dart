import 'package:security_wanyu/model/individual_notification.dart';

class IndividualNotificationTabModel {
  final List<IndividualNotification>? notifications;
  final List<IndividualNotification>? seenNotifications;
  final bool? isLoading;
  final bool? isUnlocked;
  IndividualNotificationTabModel({
    this.notifications,
    this.seenNotifications,
    this.isLoading,
    this.isUnlocked,
  });
  List<IndividualNotification> get pinnedNotifications =>
      notifications!.where((n) => n.pinned!).toList();
  int get unseenNotificationsCount =>
      notifications!.length - seenNotifications!.length;

  IndividualNotificationTabModel copyWith({
    List<IndividualNotification>? notifications,
    List<IndividualNotification>? seenNotifications,
    bool? isLoading,
    bool? isUnlocked,
  }) {
    return IndividualNotificationTabModel(
      notifications: notifications ?? this.notifications,
      seenNotifications: seenNotifications ?? this.seenNotifications,
      isLoading: isLoading ?? this.isLoading,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
