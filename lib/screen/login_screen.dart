import 'package:flutter/material.dart';
import 'package:security_wanyu/screen/base_screen.dart';
import 'package:security_wanyu/widget/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    'LOGO',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 64),
                  child: const LoginFormWidget(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (isChecked) => setState(() {
                          _isChecked = isChecked!;
                        }),
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
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const BaseScreen(),
                      ),
                    ),
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
            ),
          ),
        ),
      ),
    );
  }
}
