import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:security_wanyu/bloc/announcement_screen_bloc.dart';
import 'package:security_wanyu/screen/sign_document_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class SignableDocumentTab extends StatefulWidget {
  final AnnouncementScreenBloc bloc;
  const SignableDocumentTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<SignableDocumentTab> createState() => _SignableDocumentTabState();
}

class _SignableDocumentTabState extends State<SignableDocumentTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return !widget.bloc.model.signableDocumentTab!.isLoading!
        ? SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(widget.bloc.model
                            .signableDocumentTab!.pinnedDocs.isNotEmpty
                        ? 16
                        : 0),
                    child: Row(
                      children: List.generate(
                        widget
                            .bloc.model.signableDocumentTab!.pinnedDocs.length,
                        (index) => Container(
                          margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                          child: PinnedAnnouncementWidget(
                            title: widget.bloc.model.signableDocumentTab!
                                .pinnedDocs[index].title!,
                            onTap: () async {
                              Uint8List documentbytes = await EtunAPI.instance
                                  .downloadSignableDocument(
                                      documentId: widget
                                          .bloc
                                          .model
                                          .signableDocumentTab!
                                          .docs![index]
                                          .docId!);
                              if (!mounted) return;
                              bool? signed = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignDocumentScreen.create(
                                          documentBytes: documentbytes),
                                ),
                              );
                              if (signed != null) {
                                if (signed) {
                                  widget.bloc.markSignableDocumentAsSigned(
                                      signableDocument: widget.bloc.model
                                          .signableDocumentTab!.docs![index]);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      widget.bloc.model.signableDocumentTab!.docs!.length,
                  itemBuilder: (context, index) => AnnouncementWidget(
                    title: widget
                        .bloc.model.signableDocumentTab!.docs![index].title!,
                    announceDateTime: widget.bloc.model.signableDocumentTab!
                        .docs![index].publishDateTime!,
                    onTap: () async {
                      Uint8List documentbytes = await EtunAPI.instance
                          .downloadSignableDocument(
                              documentId: widget.bloc.model.signableDocumentTab!
                                  .docs![index].docId!);
                      if (!mounted) return;
                      bool? signed = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignDocumentScreen.create(
                              documentBytes: documentbytes),
                        ),
                      );
                      if (signed != null) {
                        if (signed) {
                          widget.bloc.markSignableDocumentAsSigned(
                              signableDocument: widget.bloc.model
                                  .signableDocumentTab!.docs![index]);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
