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
}
