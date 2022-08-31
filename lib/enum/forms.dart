enum Forms {
  leave,
  resign,
  ;

  @override
  String toString() {
    switch (this) {
      case Forms.leave:
        return '請假單';
      case Forms.resign:
        return '離職單';
    }
  }
}
