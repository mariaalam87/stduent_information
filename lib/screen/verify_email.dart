import 'dart:async';

import 'package:batch_a_29_dec/screen/home_page.dart';
import 'package:batch_a_29_dec/screen/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class VerifyEmailPage extends StatefulWidget {
  String email;
   VerifyEmailPage({Key? key,required this.email}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}
final _auth= FirebaseAuth.instance;
User? user;
Timer? timer;
class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  void initState() {
    super.initState();
    user= _auth.currentUser;
    user!.sendEmailVerification();
    timer= Timer.periodic(Duration(seconds: 5),
            (timer) {
              checkEmailVerification();
            });

  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text("A verification code has been sent to"),
            Text(widget.email,style:
              TextStyle(color: Colors.orange),),
            Text("Please verify your email"),
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerification() async{
    User? user= FirebaseAuth.instance.currentUser;
    await user!.reload();
    if(user.emailVerified){
      timer!.cancel();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context)=>HomePage()));
    }
  }
}
