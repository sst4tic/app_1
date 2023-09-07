class UsersListModel {
  UsersListModel({
    required this.btnAdd,
    required this.users,
  });

  late final bool btnAdd;
  late final List<Users> users;

  UsersListModel.fromJson(Map<String, dynamic> json) {
    btnAdd = json['btnAdd'];
    users = List.from(json['users']).map((e) => Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['btnAdd'] = btnAdd;
    _data['users'] = users.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.fullName,
    required this.name,
    this.surname,
    this.photo,
    required this.isOnline,
    required this.role,
    required this.status,
    required this.editUrl,
  });

  late final int id;
  late final String fullName;
  late final String name;
  late final String? surname;
  late final String? photo;
  late final bool isOnline;
  late final String role;
  late final String status;
  late final String? editUrl;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    name = json['name'];
    surname = json['surname'];
    photo = json['photo'];
    isOnline = json['isOnline'];
    role = json['role'];
    status = json['status'];
    editUrl = json['edit_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['name'] = name;
    data['surname'] = surname;
    data['photo'] = photo;
    data['isOnline'] = isOnline;
    data['role'] = role;
    data['status'] = status;
    data['edit_url'] = editUrl;
    return data;
  }
}
