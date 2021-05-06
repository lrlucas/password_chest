class AccountModel {
  int? id;
  String? title;
  String? url;
  String? password;
  String? note;

  AccountModel({
    this.id,
    this.title,
    this.url,
    this.password,
    this.note,
  });

  // AccountModel.fromMap(Map<String, dynamic> res)
  //     : id = res["id"],
  //       title = res["title"],
  //       url = res["url"],
  //       password = res["password"],
  //       note = res["note"];

  factory AccountModel.fromJson(Map<String, dynamic> res) => AccountModel(
        id: res["id"],
        title: res["title"],
        url: res["url"],
        password: res["password"],
        note: res["note"],
      );

  // returned like a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'password': password,
      'note': note,
    };
  }
}
