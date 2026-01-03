class SignUpBody {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? referralCode;

  SignUpBody({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.password,
    this.referralCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['referral_code'] = referralCode ?? '';
    return data;
  }
}
