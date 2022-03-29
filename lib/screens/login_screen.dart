import 'package:android_campus/main.dart';
import 'package:android_campus/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android_campus/screens/registration_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.alternate_email_rounded,
        color: Colors.green,),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "E-mail",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      //validator
      validator:(value){
        RegExp regex =new RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return ("Password is Required for Sign In");
        }
        if(!regex.hasMatch(value))
        {
          return ("Please Enter Valid Password (Min. 6 Characters)");
        }
      },
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key,
        color: Colors.green,),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );

    //login button
    final LoginButton = Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //Navigator.push(
          //  context, MaterialPageRoute(builder: (context) => HomeScreen()));

          signIn(emailController.text, passwordController.text);
        },
        //color: Colors.redAccent,
        child: Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
                padding: const EdgeInsets.all(40.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                          child: Image.asset(
                            "assets/account.png",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(height: 45),
                        emailField,
                        SizedBox(height: 10),
                        passwordField,
                        SizedBox(height: 45),
                        LoginButton,
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Dont have an account? "),
                            GestureDetector(onTap: () => Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            RegistrationForm())),
                              child: Text(
                                "Sign Up",
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
        )
    );
  }


//login function
void signIn(String email, String password) async {
  if(_formKey.currentState!.validate()){
    await _auth
    .signInWithEmailAndPassword(email: email, password: password)
    .then((uid) => {
      Fluttertoast.showToast(msg: "Login Success"),
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen())),
    })
    .catchError((e)
    {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}




}