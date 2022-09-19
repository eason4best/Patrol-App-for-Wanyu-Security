import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/sign_document_screen_bloc.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/sign_document_screen_model.dart';
import 'package:security_wanyu/model/signable_document.dart';
import 'package:security_wanyu/screen/signing_screen.dart';
import 'package:security_wanyu/widget/signature_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';

class SignDocumentScreen extends StatefulWidget {
  final SignDocumentScreenBloc bloc;
  final Member member;
  final SignableDocument signableDocument;
  final Uint8List documentBytes;
  const SignDocumentScreen({
    super.key,
    required this.bloc,
    required this.member,
    required this.signableDocument,
    required this.documentBytes,
  });

  static Widget create({
    required Member member,
    required SignableDocument signableDocument,
    required Uint8List documentBytes,
  }) {
    return Provider<SignDocumentScreenBloc>(
      create: (context) => SignDocumentScreenBloc(documentBytes: documentBytes),
      child: Consumer<SignDocumentScreenBloc>(
        builder: (context, bloc, _) => SignDocumentScreen(
          bloc: bloc,
          member: member,
          signableDocument: signableDocument,
          documentBytes: documentBytes,
        ),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  State<SignDocumentScreen> createState() => _SignDocumentScreenState();
}

class _SignDocumentScreenState extends State<SignDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SignDocumentScreenModel>(
        stream: widget.bloc.stream,
        initialData: SignDocumentScreenModel(
          documentBytes: widget.documentBytes,
          canSubmit: false,
        ),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('簽署文件'),
              actions: [
                TextButton(
                  onPressed: snapshot.data!.canSubmit!
                      ? () async {
                          await widget.bloc.submit(
                            memberId: widget.member.memberId!,
                            documentId: widget.signableDocument.docId!,
                          );
                          if (!mounted) return;
                          Navigator.of(context).pop(true);
                        }
                      : null,
                  child: const Text('完成'),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SfPdfViewerTheme(
                    data: SfPdfViewerThemeData(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      progressBarColor: Theme.of(context).primaryColor,
                    ),
                    child: SfPdfViewer.memory(
                      snapshot.data!.signedDocumentBytes != null
                          ? snapshot.data!.signedDocumentBytes!
                          : snapshot.data!.documentBytes!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  height: 56,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SigningScreen(bloc: widget.bloc),
                      ),
                    ),
                    child: SignatureWidget(
                      signatureImage: snapshot.data?.signatureImage,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
