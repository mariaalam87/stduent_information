import 'package:batch_a_29_dec/helper/custom_button.dart';
import 'package:batch_a_29_dec/helper/custom_text_field.dart';
import 'package:batch_a_29_dec/screen/home_page.dart';
import 'package:batch_a_29_dec/screen/sign_up.dart';
import 'package:batch_a_29_dec/utills/all_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}
 GlobalKey<FormState> _formKey=GlobalKey();
AllColor allColor= AllColor();
final _auth = FirebaseAuth.instance;
TextEditingController _emailController=TextEditingController();
TextEditingController _passController=TextEditingController();
class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Icon(Icons.star,
            size: 80,color: allColor.appColor,),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: "Enter your email",
              labelText: "Email",
              controller: _emailController ,
              obsecureVal: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter your password",
              labelText: "Password",
              controller: _passController ,
              obsecureVal: true,
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: (){
                signIn(
                  _emailController.text,
                    _passController.text,
                    context
                );
              },
              child: CustomButton(
                height: 60,
                width: 300,
                btnText: "LOG IN",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ",
                style: TextStyle(fontSize: 18),),
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)
                    => SignUp()));
                  },
                  child: Text(" Sign Up!",
                      style: TextStyle(fontSize: 18,
                      color: allColor.appColor)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
void signIn(String email, String pass, context) async{
  if(_formKey.currentState!.validate())
  {
    
    await _auth.signInWithEmailAndPassword
      (email: email, password: pass).then(
            (value) =>
    {
      Fluttertoast.showToast(msg: "Login Successful!!"),
      Navigator.push(context,MaterialPageRoute
        (builder: (context)=>HomePage())),
    }
    ).catchError((e){
      Fluttertoast.showToast(msg: e.message);
    });

  }
}