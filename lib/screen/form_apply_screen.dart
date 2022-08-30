import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/forms_to_apply.dart';
import 'package:security_wanyu/screen/leave_form_screen.dart';

class FormApplyScreen extends StatelessWidget {
  const FormApplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('表單申請'),
      ),
      body: ListView.builder(
        itemCount: FormsToApply.values.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(FormsToApply.values[index].toString()),
          onTap: () => FormsToApply.values[index] == FormsToApply.leave
              ? Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LeaveFormScreen.create()))
              : Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Container())),
        ),
      ),
    );
  }
}
