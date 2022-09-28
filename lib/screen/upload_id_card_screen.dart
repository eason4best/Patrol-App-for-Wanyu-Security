import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/upload_id_card_screen_bloc.dart';
import 'package:security_wanyu/enum/onboard_documents.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/upload_document_screen_model.dart';
import 'package:security_wanyu/screen/take_document_image_screen.dart';
import 'package:security_wanyu/widget/upload_onboard_document_widget.dart';

class UploadIdCardScreen extends StatelessWidget {
  final UploadIdCardScreenBloc bloc;
  const UploadIdCardScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create({required Member member}) {
    return Provider<UploadIdCardScreenBloc>(
      create: (context) => UploadIdCardScreenBloc(member: member),
      child: Consumer<UploadIdCardScreenBloc>(
        builder: (context, bloc, _) => UploadIdCardScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('身份證上傳'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<UploadDocumentScreenModel>(
            stream: bloc.stream,
            initialData: bloc.model,
            builder: (context, snapshot) {
              return Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      margin: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    '請將證件擺正，確認照片清晰，避免反光。',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: UploadOnboardDocumentWidget(
                      content: '拍攝身分證正面',
                      documentType: OnboardDocuments.idCard,
                      image: snapshot.data!.image1,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakeDocumentImageScreen(
                            documentType: OnboardDocuments.idCard,
                            cameraLensDirection: CameraLensDirection.back,
                            onShutterPressed: bloc.takeFrontImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: UploadOnboardDocumentWidget(
                      content: '拍攝身分證反面',
                      documentType: OnboardDocuments.idCard,
                      image: snapshot.data!.image2,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakeDocumentImageScreen(
                            documentType: OnboardDocuments.idCard,
                            cameraLensDirection: CameraLensDirection.back,
                            onShutterPressed: bloc.takeBackImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    margin: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: snapshot.data!.canSubmit!
                          ? () => bloc.submit().then(
                                (result) => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(result ? '身分證上傳成功' : '身分證上傳失敗'),
                                    content: Text(
                                        result ? '身分證上傳成功！' : '身分證上傳失敗，請再試一次。'),
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
    );
  }
}
