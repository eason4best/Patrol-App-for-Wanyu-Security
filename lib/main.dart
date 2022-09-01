import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/user_location_bloc.dart';
import 'package:security_wanyu/model/user_location.dart';
import 'package:security_wanyu/screen/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserLocationBloc userLocationBloc = UserLocationBloc();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>(
          initialData: userLocationBloc.model,
          create: (_) => userLocationBloc.stream,
        ),
        Provider<UserLocationBloc>(create: (context) => userLocationBloc),
      ],
      child: MaterialApp(
        title: '萬宇保全[員]',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black87,
            elevation: 0.0,
          ),
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.cyan.shade50,
        ),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW')
        ],
        debugShowCheckedModeBanner: false,
        home: LoginScreen.create(),
      ),
    );
  }
}
