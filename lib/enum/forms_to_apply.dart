enum FormsToApply {
  leave,
  resign,
  ;

  @override
  String toString() {
    switch (this) {
      case FormsToApply.leave:
        return '請假單';
      case FormsToApply.resign:
        return '離職單';
    }
  }
}
