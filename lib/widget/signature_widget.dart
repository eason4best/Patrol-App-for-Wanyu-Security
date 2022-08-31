import 'dart:typed_data';

import 'package:flutter/material.dart';

class SignatureWidget extends StatelessWidget {
  final Uint8List? signatureImage;
  const SignatureWidget({
    Key? key,
    this.signatureImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: const EdgeInsets.all(0),
        child: Center(
          child: signatureImage != null
              ? Image.memory(signatureImage!)
              : Text(
                  '請點此簽名',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
        ),
      ),
    );
  }
}
