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

  factory Member.fromData(data) {
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
