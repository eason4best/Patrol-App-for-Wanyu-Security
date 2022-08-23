class LoginScreenModel {
  final String? account;
  final String? password;
  final bool? rememberMe;
  final bool? canSubmit;

  LoginScreenModel({
    this.account,
    this.password,
    this.rememberMe,
    this.canSubmit,
  });

  LoginScreenModel copyWith({
    String? account,
    String? password,
    bool? rememberMe,
    bool? canSubmit,
  }) {
    return LoginScreenModel(
      account: account ?? this.account,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}
