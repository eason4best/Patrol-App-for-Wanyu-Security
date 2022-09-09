import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/login_screen_bloc.dart';
import 'package:security_wanyu/model/login_screen_model.dart';
import 'package:security_wanyu/widget/etun_logo.dart';
import 'package:security_wanyu/widget/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  final LoginScreenBloc bloc;
  const LoginScreen({Key? key, required this.bloc}) : super(key: key);

  static Widget create() {
    return Provider<LoginScreenBloc>(
      create: (context) => LoginScreenBloc(),
      child: Consumer<LoginScreenBloc>(
        builder: (context, bloc, _) => LoginScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
                future: bloc.initialize(),
                builder: (context, fs) {
                  return StreamBuilder<LoginScreenModel>(
                      stream: bloc.stream,
                      initialData: bloc.model,
                      builder: (context, ss) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 32),
                              child: const EtunLogo(),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 64),
                              child: LoginFormWidget(bloc: bloc, snapshot: ss),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: ss.data!.rememberMe,
                                    onChanged: bloc.rememberMe,
                                  ),
                                  Text(
                                    '記住我',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 32),
                              child: ElevatedButton(
                                onPressed: (fs.connectionState ==
                                            ConnectionState.done &&
                                        ss.data!.canSubmit!)
                                    ? () async => await bloc.signIn(context)
                                    : null,
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0.0),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 32,
                                  height: 56,
                                  child: const Center(child: Text('登入')),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
