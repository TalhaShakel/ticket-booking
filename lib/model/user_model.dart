enum Role {
  user,
  admin,
  ticketProvider;

  @override
  String toString() => name;
}

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? phoneNumber;
  Role? role = Role.user;
  UserModel(
      {this.uid, this.email, this.firstName, this.phoneNumber, this.role});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      phoneNumber: map['phoneNumber'],
      role: map['role'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      'role': role.toString(),
    };
  }
}
