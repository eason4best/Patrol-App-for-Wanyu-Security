import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class SignDocTab extends StatefulWidget {
  const SignDocTab({Key? key}) : super(key: key);

  @override
  State<SignDocTab> createState() => _SignDocTabState();
}

class _SignDocTabState extends State<SignDocTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: List.generate(
                  10,
                  (index) => Container(
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                    child: PinnedAnnouncementWidget(
                      title: '置頂待簽署文件${index + 1}.pdf',
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => AnnouncementWidget(
              title: '待簽署文件${index + 1}.pdf',
              announceDateTime: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


/*
AnnouncementWidget(
        title: '待簽署文件${index + 1}.pdf',
        onPressed: () {},
      )*/