import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/onboard_documents.dart';

class UploadOnboardDocumentWidget extends StatelessWidget {
  final String content;
  final OnboardDocuments documentType;
  final VoidCallback onTap;
  final Uint8List? image;
  const UploadOnboardDocumentWidget({
    Key? key,
    required this.content,
    required this.documentType,
    required this.onTap,
    this.image,
    required,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: image == null ? onTap : null,
      child: AspectRatio(
        aspectRatio: documentType.aspectRatio() ?? 1,
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(0),
          child: Center(
            child: image != null && image!.isNotEmpty
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onTap,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text('重拍'),
                      ),
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      content,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
