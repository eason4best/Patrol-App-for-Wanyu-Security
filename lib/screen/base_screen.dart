import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/total_unseen_announcement.dart';
import 'package:security_wanyu/screen/announcement_screen.dart';
import 'package:security_wanyu/screen/home_screen.dart';
import 'package:security_wanyu/widget/notification_dot.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();

  static Widget create({required Member member}) {
    return MultiProvider(
      providers: [
        Provider<Member>(create: (context) => member),
        ChangeNotifierProvider<TotalUnseenAnnouncement>(
          create: (context) => TotalUnseenAnnouncement(),
        ),
      ],
      child: Consumer<Member>(
        builder: (context, bloc, _) => const BaseScreen(),
      ),
    );
  }
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      HomeScreen.create(),
      AnnouncementScreen.create(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black54,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '主頁',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: const [
                  Icon(Icons.campaign_outlined),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: NotificationDot(),
                  ),
                ],
              ),
              activeIcon: const Icon(Icons.campaign),
              label: '公告',
            )
          ],
        ));
  }
}
