import 'package:batch_a_29_dec/helper/custom_button.dart';
import 'package:batch_a_29_dec/helper/custom_text_field.dart';
import 'package:batch_a_29_dec/model/user_model.dart';
import 'package:batch_a_29_dec/screen/log_in.dart';
import 'package:batch_a_29_dec/utills/all_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}
final _auth= FirebaseAuth.instance;
AllColor allColor= AllColor();
TextEditingController _emailController=TextEditingController();
TextEditingController _passController=TextEditingController();
TextEditingController _confirmPassController=TextEditingController();
TextEditingController _ageController=TextEditingController();
TextEditingController _phoneController=TextEditingController();
TextEditingController _nameController=TextEditingController();

class _SignUpState extends State<SignUp> {
 final _formKeySignUp= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKeySignUp,
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
                hintText: "Enter your full-name",
                labelText: "Name",
                controller: _nameController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Enter your phone number",
                labelText: "Phone",
                controller: _phoneController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Enter your Age",
                labelText: "Age",
                controller: _ageController ,
                obsecureVal: false,
              ),
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
                hintText: "Enter new password",
                labelText: "Password",
                controller: _passController ,
                obsecureVal: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Re-enter your password",
                labelText: "Confirm Password",
                controller: _confirmPassController ,
                obsecureVal: true,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: (){
                 signUp(_emailController.text,
                     _passController.text,
                     context,_formKeySignUp
                 );
                 },
                child: CustomButton(
                  height: 60,
                  width: 300,
                  btnText: "Sign Up",
                ),
              ),
              SizedBox(
                height: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
void signUp(String email, String password,
    context,_formKeySignUp)async{
  if(_formKeySignUp.currentState!.validate()){
    await _auth.createUserWithEmailAndPassword
      (email: email, password: password)
        .then((value) => {
          saveUserDetails(),
          Fluttertoast.showToast(msg: "SignUp Successful!"),
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>LogIn()))
    }).catchError((e){
      Fluttertoast.showToast(msg:e.message);

    });
  }

}

void saveUserDetails() async{
  FirebaseFirestore firestore123=
      FirebaseFirestore.instance;
  User? user= _auth.currentUser;
  
  UserModel userModel=UserModel();
  userModel.uid=user!.uid;
  userModel.email= _emailController.text;
  userModel.phone= _phoneController.text;
  userModel.age= _ageController.text;
  userModel.name= _nameController.text;
  
  await firestore123.collection("users")
  .doc(user.uid)
  .set(userModel.toMap());
  Fluttertoast.showToast(msg: "Data Saved Successfully");
}