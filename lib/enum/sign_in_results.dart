enum SignInResults {
  success,
  wrongPassword,
  error;

  @override
  String toString() {
    switch (this) {
      case SignInResults.success:
        return '登入成功';
      case SignInResults.wrongPassword:
        return '密碼錯誤';
      case SignInResults.error:
        return '發生錯誤';
    }
  }
}
