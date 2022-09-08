import 'package:flutter/material.dart';

class TotalUnseenAnnouncement extends ChangeNotifier {
  int _totalUnseenAnnouncements = 0;

  int get totalUnseenAnnouncements => _totalUnseenAnnouncements;

  void increase(int count) {
    _totalUnseenAnnouncements += count;
    notifyListeners();
  }

  void decrease(int count) {
    _totalUnseenAnnouncements -= count;
    notifyListeners();
  }
}
