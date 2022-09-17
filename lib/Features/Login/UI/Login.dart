import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample/Features/HomeTabbar/HomeTabBar.dart';
import 'package:fluttersample/Features/Login/Bloc/LoginEvent/LoginEvent.dart';
import 'package:fluttersample/Features/Login/Bloc/LoginState/LoginState.dart';
import 'package:fluttersample/Features/Login/Bloc/Repository/LoginRepository.dart';
import 'package:fluttersample/Features/Login/Bloc/loginbloc.dart';
import 'dart:async';
import '../../Movie/MovieScreen.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample login",
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: MultiBlocProvider(providers: [
            BlocProvider<LoginBloc>(
              create: (context) =>
                  LoginBloc(loginRepository: LoginRepository()),
            )
          ], child: LoginSignUpContainer())),
    );
  }
}

class LoginSignUpContainer extends StatefulWidget {
  const LoginSignUpContainer({Key? key}) : super(key: key);

  @override
  State<LoginSignUpContainer> createState() => _LoginSignUpContainerState();
}

class _LoginSignUpContainerState extends State<LoginSignUpContainer> {
  var appBar = AppBar();
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          return Stack(alignment: AlignmentDirectional.center, children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            getLoginView()
          ]);
        } else {
          return getLoginView();
        }
      },
      listener: (context, state) {
        if (state.status == LoginStatus.loginSuccess) {
          print("loginSuccess" + state.session.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomeTabBar(sessionID: state.session.toString())));
        } else if (state.status == LoginStatus.loginFailure) {
          print("loginFailure" + state.error.toString());
          Widget okButton = TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          );
          AlertDialog alert = AlertDialog(
            title: Text("Error"),
            content: Text(state.error.toString()),
            actions: [okButton],
          );
          showDialog(
              context: context,
              builder: (context) {
                return alert;
              });
        }
      },
    ));
  }

  Widget getLoginView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height) /
              3,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ResizeImage(AssetImage('asset/images/Batman-logo.png'),
                    width: 200, height: 100),
                fit: BoxFit.none,
                alignment: Alignment.center),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: TextFormField(
                initialValue: username,
                onChanged: (value) {
                  username = value.toString();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  print("value $value");
                  var valueString = value as String;
                  if (value is String) {
                    if (valueString.isValidEmail()) {
                      return null;
                    }
                  }
                  return 'Please enter valid email';
                },
                // ignore: deprecated_member_use
                maxLength: 30,
                scrollPadding: EdgeInsets.fromLTRB(40, 0, 10, 0),
                decoration: InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: TextFormField(
              initialValue: password,
              onChanged: (value) {
                password = value.toString();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (value is String) {
                  if (valueString.length > 10) {
                    return null;
                  }
                }
                return 'Choose strong password';
              },
              // ignore: deprecated_member_use
              maxLength: 20,
              obscureText: true,
              scrollPadding: EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: ElevatedButton(
              onPressed: () => context
                  .read<LoginBloc>()
                  .add(LoginUser(username: username, password: password)),
              child: Text("Login"),
            ),
          ),
        )
      ],
    );
  }
}
