import 'dart:ui';
import 'package:android_campus/models/user_model.dart';
import 'package:android_campus/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:android_campus/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  //editing controller
  final namaEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final noHPEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Nama Input
    final namaField = TextFormField(
      autofocus: false,
      enableSuggestions: true,
      cursorColor: Colors.black45,
      controller: namaEditingController,
      keyboardType: TextInputType.text,
      validator:(value){
        RegExp regex =new RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return ("Full Name is Required for Sign Up");
        }
        if(!regex.hasMatch(value))
        {
          return ("Please Enter Valid Name (Min. 3 Characters)");
        }
        return null;
      },
      onSaved: (value){
        namaEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.supervised_user_circle_sharp,
            color: Colors.green,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.green, width: 1.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    //Email Input
    final emailField = TextFormField(
      autofocus: false,
      enableSuggestions: true,
      cursorColor: Colors.green,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
         return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
        {
          return ("Please Enter a Valid Email");
        }
        return null;
      },
      onSaved: (value){
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.alternate_email_rounded,
            color: Colors.green,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "E-mail",
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.green, width: 1.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    //Nomor HP
    final noHPField = TextFormField(
      autofocus: false,
      enableSuggestions: true,
      cursorColor: Colors.green,
      controller: noHPEditingController,
      keyboardType: TextInputType.number,
      validator:(value){
        String pattern = r'(^[0-9]*$)';
        RegExp regex = new RegExp(pattern);
        if(value!.isEmpty)
        {
          return ("Hanphone Number is Required for Sign Up");
        }
        if(!regex.hasMatch(value))
        {
          return ("Please Enter Valid Phone Number");
        }
        return null;
      },
       onSaved: (value){
        noHPEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.green,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Handphone",
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.green, width: 1.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      cursorColor: Colors.green,
      controller: passwordEditingController,
      validator:(value){
        RegExp regex =new RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return ("Password is Required for Sign Up");
        }
        if(!regex.hasMatch(value))
        {
          return ("Please Enter Valid Password (Min. 6 Characters)");
        }
      },
      onSaved: (value){
        passwordEditingController.text = value!;
      },
      //keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.green,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.green, width: 1.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    //login button
    final LoginButton = Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5),
      color: Colors.green,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
           context, MaterialPageRoute(builder: (context) => HomeScreen()));

          signUp(emailEditingController.text, passwordEditingController.text);
        },

        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(5, 9),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          child: Image.asset(
                            "assets/edit.png",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),

                          ],
                        ),
                        SizedBox(height: 16),
                        namaField,
                        SizedBox(height: 16),
                        emailField,
                        SizedBox(height: 16),
                        noHPField,
                        SizedBox(height: 16),
                        passwordField,
                        SizedBox(height: 16),
                        LoginButton,
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => LoginScreen()));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ));

    // return Container();
  }

void signUp(String email, String password) async {
  if(_formKey.currentState!.validate()){
    await _auth.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) => {
      postDetailsToFirestore()
        
    }).catchError((e)
    {
      Fluttertoast.showToast(msg: e!.message);
    });
  }  
}
postDetailsToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = namaEditingController.text;
    userModel.handphone = noHPEditingController.text;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Your Account Created Successfully");

    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false);

  }
}
