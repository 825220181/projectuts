class User{
  late int? userid;
  late string? username;
  late string? password;

  User({this.userid, this.username, this.password});
  User.fromMap(dynamic obj){
    this.userid = obj['userid'];
    this.username = obk['username'];
    this.password = obj['password'];
  }

  Map<String,dynamuc> toMap(){
    var map = <String,dynamic>{
      'usernmae': username,
      'password': password
    };
    return map;
  }
}