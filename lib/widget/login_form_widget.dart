import 'package:flutter/material.dart';
import 'package:security_wanyu/bloc/login_screen_bloc.dart';
import 'package:security_wanyu/model/login_screen_model.dart';

class LoginFormWidget extends StatelessWidget {
  final LoginScreenBloc bloc;
  final AsyncSnapshot<LoginScreenModel> snapshot;
  const LoginFormWidget({
    Key? key,
    required this.bloc,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: bloc.accountController,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline_outlined),
            hintText: '帳號',
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          textInputAction: TextInputAction.next,
          onChanged: bloc.onInputAccount,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: TextField(
            controller: bloc.passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password_outlined),
              hintText: '密碼',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: bloc.onInputPassword,
          ),
        ),
      ],
    );
  }
}
