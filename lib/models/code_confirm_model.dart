class CodeConfirmModel {
  Datam? data;

  CodeConfirmModel({this.data});

  CodeConfirmModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Datam.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Datam {
  int? id;
  String? token;
  String? deviceToken;
  String? language;
  String? phone;
  String? name;
  String? lastname;
  String? photo;
  dynamic? rating;
  String? passportPhoto;
  String? driverLicensePhoto;
  dynamic balance;

  Datam(
      {this.id,
      this.token,
      this.deviceToken,
      this.language,
      this.phone,
      this.name,
      this.lastname,
      this.photo,
      this.rating,
      this.balance,
      this.passportPhoto,
      this.driverLicensePhoto});

  Datam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    deviceToken = json['device_token'];
    language = json['language'];
    phone = json['phone'];
    name = json['name'];
    lastname = json['lastname'];
    photo = json['photo'];
    rating = json['rating'];
    balance = json['balance'];
    passportPhoto = json['passportPhoto'];
    driverLicensePhoto = json['driverLicensePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['device_token'] = this.deviceToken;
    data['language'] = this.language;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['photo'] = this.photo;
    data['balance'] = this.balance;
    data['rating'] = this.rating;
    data['passportPhoto'] = this.passportPhoto;
    data['driverLicensePhoto'] = this.driverLicensePhoto;
    return data;
  }
}
