class Account {
  int id;
  String title;
  String url;
  String password;
  String note;

  Account({this.id, this.title, this.url, this.password, this.note});

  Account.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        url = res["url"],
        password = res["password"],
        note = res["note"];

  // return like a json object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'password': password,
      'note': note,
    };
  }
}
