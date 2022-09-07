import 'dart:typed_data';

import 'package:flutter/material.dart';

class UploadOnboardDocumentWidget extends StatelessWidget {
  final String content;
  final double aspectRatio;
  final VoidCallback onTap;
  final Uint8List? image;
  const UploadOnboardDocumentWidget({
    Key? key,
    required this.content,
    required this.aspectRatio,
    required this.onTap,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(0),
          child: Center(
            child: image != null && image!.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Text(
                    content,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
          ),
        ),
      ),
    );
  }
}
