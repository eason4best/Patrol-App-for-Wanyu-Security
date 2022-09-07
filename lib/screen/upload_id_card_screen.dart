import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/upload_id_card_screen_bloc.dart';
import 'package:security_wanyu/model/upload_id_card_screen_model.dart';
import 'package:security_wanyu/screen/take_document_image_screen.dart';
import 'package:security_wanyu/widget/upload_onboard_document_widget.dart';

class UploadIdCardScreen extends StatelessWidget {
  final UploadIdCardScreenBloc bloc;
  const UploadIdCardScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create() {
    return Provider<UploadIdCardScreenBloc>(
      create: (context) => UploadIdCardScreenBloc(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<UploadIdCardScreenModel>(
              stream: bloc.stream,
              initialData: bloc.model,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    UploadOnboardDocumentWidget(
                      content: '拍攝身分證正面',
                      aspectRatio: 85.7 / 54,
                      image: snapshot.data!.frontImage,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakeDocumentImageScreen(
                            documentAspectRatio: 85.7 / 54,
                            onShutterPressed: bloc.takeFrontImage,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: UploadOnboardDocumentWidget(
                        content: '拍攝身分證反面',
                        aspectRatio: 85.7 / 54,
                        image: snapshot.data!.backImage,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TakeDocumentImageScreen(
                              documentAspectRatio: 85.7 / 54,
                              onShutterPressed: bloc.takeBackImage,
                            ),
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
                            ? () async => await bloc.submit()
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
