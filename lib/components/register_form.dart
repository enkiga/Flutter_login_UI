import 'package:flutter/material.dart';
import 'package:flutter_login/components/rounded_button.dart';
import 'package:flutter_login/components/rounded_input.dart';
import 'package:flutter_login/components/rounded_password_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
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
    );
  }
}

