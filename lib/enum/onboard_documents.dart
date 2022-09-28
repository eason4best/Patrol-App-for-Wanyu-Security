enum OnboardDocuments {
  idCard,
  bankbook,
  headshot,
  otherDocument;

  @override
  String toString() {
    switch (this) {
      case OnboardDocuments.idCard:
        return '身分證';
      case OnboardDocuments.bankbook:
        return '存摺';
      case OnboardDocuments.headshot:
        return '大頭照';
      case OnboardDocuments.otherDocument:
        return '其他文件';
    }
  }

  double? aspectRatio() {
    switch (this) {
      case OnboardDocuments.idCard:
        return 85.7 / 54;
      case OnboardDocuments.bankbook:
        return 16 / 9;
      case OnboardDocuments.headshot:
        return 1;
      case OnboardDocuments.otherDocument:
        return null;
    }
  }
}
