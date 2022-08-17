enum ContactUs {
  phone,
  email,
  ;

  @override
  String toString() {
    switch (this) {
      case ContactUs.phone:
        return '電話';
      case ContactUs.email:
        return '電子信箱';
    }
  }
}
