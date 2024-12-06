import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram/data/firebase_service/firebase_auth.dart';
import 'package:instagram/util/dialog.dart';
import 'package:instagram/util/exception.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;

  const SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final passwordConfirm = TextEditingController();
  FocusNode passwordConfirm_F = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 96.w,
              height: 30.h,
            ),
            Center(
              child: Image.asset('assets/logo.jpg'),
            ),
            SizedBox(height: 60.h),
            Center(
                child: CircleAvatar(
              radius: 34.r,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage('assets/person.png'),
            )),
            SizedBox(height: 50.h),
            Textfield(
              email,
              Icons.email,
              'Email',
              email_F,
            ),
            SizedBox(height: 15.h),
            Textfield(
              username,
              Icons.person,
              'Username',
              password_F,
            ),
            SizedBox(height: 15.h),
            Textfield(
              bio,
              Icons.abc,
              'bio',
              bio_F,
            ),
            SizedBox(height: 15.h),
            Textfield(
              password,
              Icons.lock,
              'Password',
              password_F,
            ),
            SizedBox(height: 15.h),
            Textfield(
              passwordConfirm,
              Icons.lock,
              'PasswordConfirm',
              passwordConfirm_F,
            ),
            SizedBox(height: 20.h),
            Singup(),
            SizedBox(height: 10.h),
            Have()
          ],
        ),
      ),
    );
  }

  Widget Have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have account?  ",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Login ',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Singup() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          try {
            await Authentication().Signup(
              email: email.text,
              password: password.text,
              passwordConfirm: passwordConfirm.text,
              username: username.text,
              bio: bio.text,
              profile: File(''),
            );
          } on Exceptions catch (e) {
            dialogBuilder(
              context,
              e.message,
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 23.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget Forget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        'Forget your password?',
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Textfield(
    TextEditingController controller,
    IconData icon,
    String type,
    FocusNode focusNode,
  ) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextField(
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
          ),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
