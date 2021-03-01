import 'package:arquiteturas_flutter/archs/mvc/login_controller.dart';
import 'package:arquiteturas_flutter/archs/mvc/model/login_repository.dart';
import 'package:arquiteturas_flutter/home_page.dart';
import 'package:flutter/material.dart';

class LoginViewMVC extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginViewMVC> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginController loginController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loginController = LoginController(LoginRepository());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loginSuccess() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  _loginError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Erro ao realizar o login"),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Teste"),
      ),
      body: Form(
        key: loginController.formKey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                onSaved: (value) => loginController.userEmail = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email não pode ser vazio!";
                  } else if (!value.contains("@")) {
                    return "Email informado não é valido!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Senha"),
                onSaved: (value) => loginController.userPassword = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Senha não pode ser vazia!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (await loginController.login()) {
                          _loginSuccess();
                        } else {
                          _loginError();
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text("Enter"),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
