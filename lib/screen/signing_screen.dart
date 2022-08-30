import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signature/signature.dart';

class SigningScreen extends StatefulWidget {
  final dynamic bloc;

  const SigningScreen({
    super.key,
    required this.bloc,
  });

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('請於空白處簽名'),
        actions: [
          TextButton(
            onPressed: () async => await widget.bloc.completeSigning(
              width: MediaQuery.of(context).size.width.round(),
              height: MediaQuery.of(context).size.height.round(),
              context: context,
            ),
            child: const Text('完成'),
          )
        ],
      ),
      body: Signature(
        controller: widget.bloc.signatureController,
        backgroundColor: Colors.white,
      ),
    );
  }
}
