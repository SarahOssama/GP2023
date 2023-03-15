import 'package:audima/presentaion/login/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../responsive.dart';
import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = LoginViewModel();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _loginViewModel.start(); //tell viewmodel start your job
    _usernameController.addListener(
        () => _loginViewModel.setUsername(_usernameController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Audima',
            style: ResponsiveTextStyles.audima(context),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/home.jpg'),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('assets/images/audimalogo.png'),
                ),
                SizedBox(
                  height: 60,
                ),
                StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsUsernameValid,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 600),
                        child: TextField(
                          controller: _usernameController,
                          style:
                              ResponsiveTextStyles.loginInfoTextStyle(context),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle:
                                ResponsiveTextStyles.businessInfoHintStyle(
                                    context),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            hintText: "Username",
                            errorText: (snapshot.data ?? true)
                                ? null
                                : "Please enter your username",
                          ),
                          cursorColor: Colors.white,
                          cursorHeight: 30,
                        ),
                      );
                    }),
                SizedBox(
                  height: 50,
                ),
                StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 600),
                        child: TextField(
                          controller: _passwordController,
                          style:
                              ResponsiveTextStyles.loginInfoTextStyle(context),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle:
                                ResponsiveTextStyles.businessInfoHintStyle(
                                    context),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            hintText: "Password",
                            errorText: (snapshot.data ?? true)
                                ? null
                                : "Please enter your password",
                          ),
                          cursorColor: Colors.white,
                          cursorHeight: 30,
                        ),
                      );
                    }),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 40,
                  width: ResponsiveValues.aboutUsBrowseProductsWidth(context),
                  child: StreamBuilder<bool>(
                      stream: _loginViewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              backgroundColor: (snapshot.data ?? false)
                                  ? MaterialStateProperty.all(Colors.white)
                                  : MaterialStateProperty.all(Colors.grey)),
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _loginViewModel.login();
                                  context.go("/home");
                                }
                              : null,
                          child: CustomizedText(
                              text: "Login",
                              textStyle:
                                  ResponsiveTextStyles.startYourBusinessJourney(
                                      context)),
                        );
                      }),
                ),
              ],
            ),
          ],
        ));
  }
}
