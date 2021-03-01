import 'package:arquiteturas_flutter/archs/mvc/model/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'model/user_model.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();

  final LoginRepository repository;
  var userModel = UserModel();

  LoginController(this.repository);

  set userEmail(String email) => userModel.email = email;
  set userPassword(String password) => userModel.password = password;

  Future<bool> login() async {
    if (!formKey.currentState.validate()) {
      return false;
    }
    formKey.currentState.save();

    try{
      return await repository.login(userModel); 
    }catch(ex){
      return false;
    }
  }
}
