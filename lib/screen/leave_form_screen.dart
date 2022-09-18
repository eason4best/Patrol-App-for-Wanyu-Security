import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/leave_form_screen_bloc.dart';
import 'package:security_wanyu/model/leave_form_screen_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/screen/signing_screen.dart';
import 'package:security_wanyu/widget/signature_widget.dart';

class LeaveFormScreen extends StatelessWidget {
  final LeaveFormScreenBloc bloc;
  const LeaveFormScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create({required Member member}) {
    return Provider<LeaveFormScreenBloc>(
      create: (context) => LeaveFormScreenBloc(member: member),
      child: Consumer<LeaveFormScreenBloc>(
        builder: (context, bloc, _) => LeaveFormScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('請假單'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<LeaveFormScreenModel>(
            stream: bloc.stream,
            initialData: bloc.model,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextField(
                        controller: bloc.nameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          hintText: '姓名',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: bloc.onInputName,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextField(
                        controller: bloc.titleController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.work_outline_outlined),
                          hintText: '職稱',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: bloc.onInputTitle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextField(
                        controller: bloc.leaveTypeController,
                        readOnly: true,
                        onTap: () => bloc.onSelectLeaveType(context: context),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.category_outlined),
                          hintText: '假別',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextField(
                        controller: bloc.leaveReasonController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.text_fields_outlined),
                          hintText: '請假事由',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: bloc.onInputLeaveReason,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      margin: const EdgeInsets.only(top: 32),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async =>
                                await bloc.pickDate(context: context),
                            child: Container(
                              margin: const EdgeInsets.only(left: 12),
                              child: Text(
                                Utils.datetimeString(
                                  snapshot.data!.leaveForm!.startDateTime!,
                                  onlyDate: true,
                                  showWeekday: true,
                                  isMinguo: true,
                                ),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async =>
                                await bloc.pickTime(context: context),
                            child: Text(
                              Utils.datetimeString(
                                snapshot.data!.leaveForm!.startDateTime!,
                                onlyTime: true,
                              ),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Text(
                            '請假至',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.black54, height: 1),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async => await bloc.pickDate(
                                context: context, isStartDateTime: false),
                            child: Container(
                              margin: const EdgeInsets.only(left: 12),
                              child: Text(
                                Utils.datetimeString(
                                  snapshot.data!.leaveForm!.endDateTime!,
                                  onlyDate: true,
                                  showWeekday: true,
                                  isMinguo: true,
                                ),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async => await bloc.pickTime(
                                context: context, isStartDateTime: false),
                            child: Text(
                              Utils.datetimeString(
                                snapshot.data!.leaveForm!.endDateTime!,
                                onlyTime: true,
                              ),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SigningScreen(bloc: bloc),
                          ));
                        },
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: SignatureWidget(
                              signatureImage:
                                  snapshot.data!.leaveForm!.signatureImage),
                        ),
                      ),
                    ),
                    Container(
                      height: 56,
                      margin: const EdgeInsets.only(top: 32, bottom: 16),
                      child: ElevatedButton(
                        onPressed: snapshot.data!.canSubmit!
                            ? () async => await bloc.submit(context: context)
                            : null,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Center(child: Text('提交')),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
