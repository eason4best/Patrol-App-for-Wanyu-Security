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
        title: RichText(
            text: TextSpan(
          text: '請於簽名處用',
          style: Theme.of(context).textTheme.headline6,
          children: [
            TextSpan(
                text: '正楷',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold)),
            TextSpan(
              text: '簽名',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        )),
        actions: [
          TextButton(
            onPressed: () => widget.bloc.clearSigning(),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black54)),
            child: const Text('清除'),
          ),
          TextButton(
            onPressed: () async =>
                await widget.bloc.completeSigning(context: context),
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
