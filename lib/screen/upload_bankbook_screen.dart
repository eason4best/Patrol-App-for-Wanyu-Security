import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/upload_bankbook_screen_bloc.dart';
import 'package:security_wanyu/model/upload_bankbook_screen_model.dart';
import 'package:security_wanyu/screen/take_document_image_screen.dart';
import 'package:security_wanyu/widget/upload_onboard_document_widget.dart';

class UploadBankbookScreen extends StatelessWidget {
  final UploadBankbookScreenBloc bloc;
  const UploadBankbookScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create() {
    return Provider<UploadBankbookScreenBloc>(
      create: (context) => UploadBankbookScreenBloc(),
      child: Consumer<UploadBankbookScreenBloc>(
        builder: (context, bloc, _) => UploadBankbookScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('存摺上傳'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<UploadBankbookScreenModel>(
              stream: bloc.stream,
              initialData: bloc.model,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    UploadOnboardDocumentWidget(
                      content: '拍攝存摺正面',
                      aspectRatio: 16 / 9,
                      image: snapshot.data!.image,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakeDocumentImageScreen(
                            documentAspectRatio: 16 / 9,
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
