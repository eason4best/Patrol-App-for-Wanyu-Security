import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/upload_headshot_screen_bloc.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/upload_document_screen_model.dart';
import 'package:security_wanyu/screen/take_document_image_screen.dart';
import 'package:security_wanyu/widget/upload_onboard_document_widget.dart';

class UploadHeadshotScreen extends StatelessWidget {
  final UploadHeadshotScreenBloc bloc;
  const UploadHeadshotScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create({required Member member}) {
    return Provider<UploadHeadshotScreenBloc>(
      create: (context) => UploadHeadshotScreenBloc(member: member),
      child: Consumer<UploadHeadshotScreenBloc>(
        builder: (context, bloc, _) => UploadHeadshotScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('大頭照上傳'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<UploadDocumentScreenModel>(
              stream: bloc.stream,
              initialData: bloc.model,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    UploadOnboardDocumentWidget(
                      content: '拍攝大頭照',
                      aspectRatio: 1,
                      image: snapshot.data!.image1,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakeDocumentImageScreen(
                            documentAspectRatio: 1,
                            cameraLensDirection: CameraLensDirection.front,
                            onShutterPressed: bloc.takeImage,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      margin: const EdgeInsets.only(top: 32, bottom: 16),
                      child: ElevatedButton(
                        onPressed: snapshot.data!.canSubmit!
                            ? () => bloc.submit().then(
                                  (result) => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text(result ? '大頭照上傳成功' : '大頭照上傳失敗'),
                                      content: Text(result
                                          ? '大頭照上傳成功！'
                                          : '大頭照上傳失敗，請再試一次。'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text(
                                            '確認',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).then(
                                    (_) => Navigator.of(context).pop(),
                                  ),
                                )
                            : null,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Center(child: Text('上傳')),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
