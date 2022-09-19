class Member {
  final int? memberId;
  final String? memberAccount;
  final String? memberPassword;
  final String? memberName;
  final String? memberSN;
  Member({
    this.memberId,
    this.memberAccount,
    this.memberPassword,
    this.memberName,
    this.memberSN,
  });

  Map<String, dynamic> toMap() => {
        'patrol_member_id': memberId,
        'member_account': memberAccount,
        'member_password': memberPassword,
        'member_name': memberName,
        'member_sn': memberSN,
      };

  factory Member.fromMap(data) {
    if (data == null) {
      return Member();
    }
    final int? memberId = data['patrol_member_id'];
    final String? memberAccount = data['member_account'];
    final String? memberPassword = data['member_password'];
    final String? memberName = data['member_name'];
    final String? memberSN = data['member_sn'];
    return Member(
      memberId: memberId,
      memberAccount: memberAccount,
      memberPassword: memberPassword,
      memberName: memberName,
      memberSN: memberSN,
    );
  }
}
