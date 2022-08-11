enum MainFunctions {
  startPatrol,
  patrolRecord,
  patrolComfirm,
  offlinePatrol,
  uploadImage,
  signOut;

  @override
  String toString() {
    switch (this) {
      case MainFunctions.startPatrol:
        return '開始巡邏';
      case MainFunctions.patrolRecord:
        return '巡邏紀錄';
      case MainFunctions.patrolComfirm:
        return '巡邏確認';
      case MainFunctions.offlinePatrol:
        return '離線巡邏';
      case MainFunctions.uploadImage:
        return '上傳圖片資料';
      case MainFunctions.signOut:
        return '登出';
    }
  }
}
