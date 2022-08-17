import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';

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
    return ListView.builder(
      itemBuilder: (context, index) => AnnouncementWidget(
        title: '待簽署文件${index + 1}.pdf',
        onPressed: () {},
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
