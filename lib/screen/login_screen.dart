import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/login_screen_bloc.dart';
import 'package:security_wanyu/model/login_screen_model.dart';
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
            child: StreamBuilder<LoginScreenModel>(
                stream: bloc.stream,
                initialData: bloc.model,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: Text(
                          'LOGO',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 64),
                        child: LoginFormWidget(bloc: bloc, snapshot: snapshot),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: snapshot.data!.rememberMe,
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
                          onPressed: snapshot.data!.canSubmit!
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
                }),
          ),
        ),
      ),
    );
  }
}
