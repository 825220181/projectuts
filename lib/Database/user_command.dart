import 'package:sqflite.dart';
import 'package:sql/database/database_connection.dart';
import 'package:sql/module/user.dart';

class UserCommand{
  Future<int> insertUser(User user) async{
    Database db = await DatabaseConnection.instance.database;
    return await db.insert('user', user.toMap());
  }

  Future<User?> signIn(Stirng email,String password) async{
    Database db = await DatabaseConnection.instance.database;
    List<Map<String,dynamic>> maps = await db.query('user',where: 'username = ? AND password = ?', whereArgs: [email,password]);
    if(maps.isNotEmpty){
      return user.frontmap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    Database db = await DatabaseConnection.instance.database;
    return await db.update('user', user,toMap(), where: 'userid = ?',whereArgs: [user.userid]);
  }

  Future<List<User>> getuser() async{
    Database db = await DatabaseConnection.instance.database;
    List<Map<String,dynamic>> allUser = await db.query('user');
    List<User> users = allUser.map((user) => User.fromMap(user)).toList();
    return users;
  }

}