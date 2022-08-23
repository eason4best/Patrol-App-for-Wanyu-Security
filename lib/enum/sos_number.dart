enum SOSNumber {
  phone1,
  phone2,
  phone3,
  phone4;

  @override
  String toString() {
    switch (this) {
      case SOSNumber.phone1:
        return '蔡副總';
      case SOSNumber.phone2:
        return '黃經理';
      case SOSNumber.phone3:
        return '公司電話1';
      case SOSNumber.phone4:
        return '公司電話2';
    }
  }

  String getNumber() {
    switch (this) {
      case SOSNumber.phone1:
        return '0975-303-078';
      case SOSNumber.phone2:
        return '0983-700-535';
      case SOSNumber.phone3:
        return '06-3565597';
      case SOSNumber.phone4:
        return '06-3565596';
    }
  }
}
