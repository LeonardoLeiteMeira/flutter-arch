import 'package:arquiteturas_flutter/archs/mvc/model/user_model.dart';

class LoginRepository{
  Future<bool> login(UserModel userModel) async{
    //API mock
    await Future.delayed(Duration(seconds: 2));
    return (userModel.email == "leonardo@commitjr.com" && userModel.password=="1234");
  }
}