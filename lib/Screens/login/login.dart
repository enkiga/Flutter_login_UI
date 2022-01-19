import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/components/rounded_button.dart';
import 'package:flutter_login/components/rounded_input.dart';
import 'package:flutter_login/components/rounded_password_input.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late Animation<double> containerSize;
  late AnimationController animationController;
  Duration animationDuration = const Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize = Tween<double>(
            begin: size.height * 0.1, end: defaultRegisterSize)
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));

    return Scaffold(
      body: Stack(
        children: [
          //Cancel Button
          AnimatedOpacity(
            opacity: isLogin ? 0.0 : 1.0,
            duration: animationDuration,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  //returning null to disable button
                  onPressed: isLogin ? null: () { 
                    animationController.reverse();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          //Login Form
          AnimatedOpacity(
            opacity: isLogin ? 1.0 : 0.0,
            duration: animationDuration * 4,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                  child: SizedBox(
                width: size.width,
                height: defaultLoginSize,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 30),
                      SvgPicture.asset("assets/images/login.svg",
                          width: 200, height: 200),
                      const SizedBox(height: 30),
                      const RoundedInput(icon: Icons.mail, hint: 'Username'),
                      const RoundedPasswordInput(hint: 'Password'),
                      const SizedBox(height: 10),
                      const RoundedButton(title: 'LOGIN')
                    ]),
              )),
            ),
          ),

          //Register Container
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (viewInset == 0 && isLogin) {
                return buildRegisterContainer();
              } else if (!isLogin) {
                return buildRegisterContainer();
              }

              //Returning empty container to hide the widget
              return Container();
            },
          ),

          //Register Form
          AnimatedOpacity(
            opacity: isLogin ? 0.0 : 1.0,
            duration: animationDuration * 5,
            child: Visibility(
              visible: !isLogin,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                    child: SizedBox(
                  width: size.width,
                  height: defaultLoginSize,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 30),
                        SvgPicture.asset("assets/images/login.svg",
                            width: 1500, height: 150),
                        const SizedBox(height: 30),
                        const RoundedInput(icon: Icons.mail, hint: 'Username'),
                        const RoundedInput(
                            icon: Icons.face_rounded, hint: 'Name'),
                        const RoundedPasswordInput(hint: 'Password'),
                        const SizedBox(height: 10),
                        const RoundedButton(title: 'SIGNUP')
                      ]),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100), topRight: Radius.circular(100)),
            color: kBackgroundColor),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin ? null:  () {
            animationController.forward();

            setState(() {
              isLogin = !isLogin;
            });
          },
          child: isLogin
              ? const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
