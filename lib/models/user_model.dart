class UserModel{
  String? uid;
  String? email;
  String? fullName;
  String? handphone;

  UserModel({this.uid, this.email, this.fullName, this.handphone});

  //receive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      handphone: map['handphone'],
    );
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return{
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'handphone': handphone,
    };
  }
}