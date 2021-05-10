class AccountModel {
  int? id;
  String? title;
  String? url;
  String? email;
  String? password;
  String? note;

  AccountModel({
    this.id,
    this.title,
    this.email,
    this.url,
    this.password,
    this.note,
  });

  factory AccountModel.fromJson(Map<String, dynamic> res) => AccountModel(
        id: res["id"],
        title: res["title"],
        url: res["url"],
        email: res["email"],
        password: res["password"],
        note: res["note"],
      );

  // returned like a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'email': email,
      'url': url,
      'password': password,
      'note': note,
    };
  }
}
