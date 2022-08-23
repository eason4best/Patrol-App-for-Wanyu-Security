import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/sign_in_results.dart';
import 'package:security_wanyu/model/login_screen_model.dart';
import 'package:security_wanyu/screen/base_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenBloc {
  final StreamController<LoginScreenModel> _streamController =
      StreamController();
  Stream<LoginScreenModel> get stream => _streamController.stream;
  LoginScreenModel _model =
      LoginScreenModel(rememberMe: false, canSubmit: false);
  LoginScreenModel get model => _model;
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    accountController.text = prefs.getString('account') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    updateWith(
      account: accountController.text,
      password: passwordController.text,
      canSubmit: _canSubmit(),
    );
  }

  void onInputAccount(String account) {
    updateWith(
      account: account,
      canSubmit: _canSubmit(),
    );
  }

  void onInputPassword(String password) {
    updateWith(
      password: password,
      canSubmit: _canSubmit(),
    );
  }

  void rememberMe(bool? isChecked) {
    updateWith(rememberMe: isChecked);
  }

  Future<void> signIn(BuildContext context) async {
    final navigator = Navigator.of(context);
    //確認有無連上網路。
    if (await _hasInternetConnection()) {
      SignInResults result = await EtunAPI.signIn(
          memberAccount: _model.account!, memberPassword: _model.password!);
      switch (result) {
        case SignInResults.success:
          if (_model.rememberMe!) {
            prefs.setString('account', _model.account!);
            prefs.setString('password', _model.password!);
          }
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
    } else {
      if (_model.account == prefs.getString('account') &&
          _model.password == prefs.getString('password')) {
        if (navigator.mounted) {
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BaseScreen(),
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('登入失敗'),
            content: const Text('離線登入帳號或密碼錯誤。'),
            actions: <Widget>[
              TextButton(
                child: const Text('確認'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  bool _canSubmit() {
    return accountController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
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
