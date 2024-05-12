import 'package:TheStafferEmployee/main.dart';
import 'package:TheStafferEmployee/screens/Login/login_bloc/login_bloc.dart';
import 'package:TheStafferEmployee/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TheStafferEmployee/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as s;

final _formKey = GlobalKey<FormState>();

class LoginForm extends StatefulWidget {
  LoginForm() : super(key: null);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  void showLoginError() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Text(
          'Invalid credentials',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
     @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var loginBloc = context.read<LoginBloc>();

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginFailureState){
          return showLoginError();
        }
        if(state is LoginSuccessState) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
              height: double.infinity,
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Group 12874.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14),
                        Image.asset(
                          "images/Group 12869.png",
                          height: size.height * 0.10,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10),
                        Container(
                          alignment: Alignment.centerLeft,
                          child:const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        TextFormField(
                          validator: (value) => value == null
                              ? null
                              : value.isEmpty
                                  ? "please provide an email"
                                  : null,
                          style:const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                          ),
                          cursorColor: Colors.white,
                          controller: _usernameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white60),
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white60),
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding:
                             const   EdgeInsets.only(left: 10.0, right: 10.0),
                            labelText: "Username",
                            hintStyle:const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            labelStyle:const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          autocorrect: false,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) => value == null
                              ? null
                              : value.isEmpty
                                  ? "please provide an password"
                                  : null,
                          obscureText: _showPassword,
                          style:const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: _showPassword
                                  ?const Icon(
                                      Icons.visibility,
                                      color: Colors.white60,
                                    )
                                  :const Icon(
                                      Icons.visibility_off,
                                      color: Colors.white60,
                                    ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white60),
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white60),
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding:
                              const  EdgeInsets.only(left: 10.0, right: 10.0),
                            labelText: "Password",
                            hintStyle:const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            labelStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          autocorrect: false,
                        ),
                       const SizedBox(
                          height: 18.0,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _launchURL();
                              });
                            },
                            child:const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(top: 30.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 45,
                                child: state is LoginLoadingState
                                    ?const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 25.0,
                                                width: 25.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Style.Colors
                                                              .mainColor),
                                                  strokeWidth: 4.0,
                                                ),
                                              )
                                            ],
                                          )),
                                        ],
                                      )
                                    : ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                           var sharedPreferences=await SharedPreferences.getInstance();
                                           sharedPreferences.setBool(MyAppState.keyLogin, true);
                                           //here we add th event
                                           loginBloc.add(LoginButtonPressed(email: _usernameController.text,
                                            password: _passwordController.text));
                                          }
                                        },
                                        child:const Text(
                                          "LOG IN",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}

void _togglePasswordVisibility() {
  // setState(() {
  //   _showPassword = !_showPassword;
  // });
}

void _launchURL() async {
  final String _url = 'https://dev5.thestaffer.com/login';
  if (!await launch(_url)) throw 'Could not launch $_url';
}
