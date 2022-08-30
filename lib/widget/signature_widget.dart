import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:security_wanyu/screen/signing_screen.dart';

class SignatureWidget extends StatelessWidget {
  final dynamic bloc;
  final Uint8List? signatureImage;
  const SignatureWidget({
    Key? key,
    required this.bloc,
    this.signatureImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SigningScreen(bloc: bloc),
      )),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Card(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: signatureImage != null
                  ? DecorationImage(image: MemoryImage(signatureImage!))
                  : null,
            ),
            child: signatureImage != null
                ? null
                : Center(
                    child: Text(
                      '請點此簽名',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
