enum PunchCards {
  work,
  getOff,
  makeUp,
  ;

  @override
  String toString() {
    switch (this) {
      case PunchCards.work:
        return '上班';
      case PunchCards.getOff:
        return '下班';
      case PunchCards.makeUp:
        return '補班';
    }
  }
}
