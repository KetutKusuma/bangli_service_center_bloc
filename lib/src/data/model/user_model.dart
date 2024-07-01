class UserModel {
  String? id, name, phone, npPDAM, createdAt, updatedAt;

  UserModel({
    this.id,
    this.name,
    this.npPDAM,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> res) {
    return UserModel(
      id: res['id'],
      name: res['name'],
      npPDAM: res['np_pdam'],
      phone: res['phone'],
      createdAt: res['created_at'],
      updatedAt: res['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {
      'id': id,
      'name': name,
      'np_pdam': npPDAM,
      'phone': phone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''{
              'id' : '$id',
              'name' : '$name',
              'np_pdam' : '$npPDAM',
              'phone' : '$phone',
              'created_at' : '$createdAt',
              'updated_at' : '$updatedAt',
               }
            ''';
  }
}
