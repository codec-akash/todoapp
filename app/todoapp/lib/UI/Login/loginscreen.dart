import 'package:flutter/material.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/models/global.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginPage({Key key, this.newUser, this.login})
      : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: darkGreyColor,
      body: Center(
        child: widget.newUser ? getSignupPage() : getSigninPage(),
      ),
    );
  }

  Widget getSigninPage() {
    TextEditingController usernameText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();
    return SafeArea(
      child: Container(
        margin:
            EdgeInsets.only(top: 100, right: 20.0, left: 20.0, bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Welcome!",style: bigLightBlueTitle,),
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Theme(
                    data: Theme.of(context)
                        .copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: usernameText,
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 22.0, color: darkGreyColor),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: passwordText,
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 22.0, color: darkGreyColor),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if(usernameText.text != null || passwordText.text != null){
                        userBloc.signinUser(usernameText.text, passwordText.text,"").then((_){
                          print("HEllO");
                          widget.login();
                        });
                      }
                    },
                    child: Text("Sign-In",style: redTodoTitle,),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("Dont have an account ?",style: redText),
                  FlatButton(
                    onPressed: (){

                    },
                    child: Text("Create One",style: redBoldText,),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSignupPage() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Enter email'),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(hintText: 'UserName'),
          ),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(hintText: 'First Name'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'PassWord'),
          ),
          FlatButton(
            color: Colors.red,
            child: Text('Sign - Up'),
            onPressed: () {
              if (usernameController.text != null ||
                  passwordController.text != null ||
                  emailController.text != null) {
                userBloc
                    .registerUser(
                        usernameController.text,
                        firstNameController.text ?? "",
                        "",
                        emailController.text,
                        passwordController.text)
                    .then((_) {
                  widget.login();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
