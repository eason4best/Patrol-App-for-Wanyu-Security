import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/screen/announcement_screen.dart';
import 'package:security_wanyu/screen/home_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();

  static Widget create({required Member member}) {
    return Provider<Member>(
      create: (context) => member,
      child: Consumer<Member>(
        builder: (context, bloc, _) => const BaseScreen(),
      ),
    );
  }
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;
  final pages = [
    HomeScreen.create(),
    const AnnouncementScreen(),
  ];

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
                children: [
                  const Icon(Icons.campaign_outlined),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '5',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
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
