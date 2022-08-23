import 'dart:async';
import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/sign_in_results.dart';
import 'package:security_wanyu/model/login_screen_model.dart';
import 'package:security_wanyu/screen/base_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';

class LoginScreenBloc {
  final StreamController<LoginScreenModel> _streamController =
      StreamController();
  Stream<LoginScreenModel> get stream => _streamController.stream;
  LoginScreenModel _model = LoginScreenModel(
      account: '', password: '', rememberMe: false, canSubmit: false);
  LoginScreenModel get model => _model;

  void onInputAccount(String account) {
    updateWith(
      account: account,
      canSubmit: _canSubmit(account, _model.password),
    );
  }

  void onInputPassword(String password) {
    updateWith(
      password: password,
      canSubmit: _canSubmit(_model.account, password),
    );
  }

  void rememberMe(bool? isChecked) {
    updateWith(rememberMe: isChecked);
  }

  Future<void> signIn(BuildContext context) async {
    final navigator = Navigator.of(context);
    SignInResults result = await EtunAPI.signIn(
        memberAccount: _model.account!, memberPassword: _model.password!);
    switch (result) {
      case SignInResults.success:
        if (navigator.mounted) {
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BaseScreen(),
            ),
          );
        }
        break;
      case SignInResults.wrongPassword:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('登入失敗'),
            content: const Text('帳號或密碼錯誤。'),
            actions: <Widget>[
              TextButton(
                child: const Text('確認'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        break;
      case SignInResults.error:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('登入失敗'),
            content: const Text('發生錯誤。'),
            actions: <Widget>[
              TextButton(
                child: const Text('確認'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        break;
    }
  }

  bool _canSubmit(String? account, String? password) {
    return account!.isNotEmpty && password!.isNotEmpty;
  }

  void updateWith({
    String? account,
    String? password,
    bool? rememberMe,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      account: account,
      password: password,
      rememberMe: rememberMe,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    _streamController.close();
  }
}
