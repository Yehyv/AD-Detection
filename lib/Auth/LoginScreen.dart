import 'package:bio2/Auth/RegisterScreen.dart';
import 'package:bio2/Homepage.dart';
import 'package:bio2/custom%20widgets/customText.dart';
import 'package:bio2/custom%20widgets/textFormFeild.dart';
import 'package:bio2/paints/AppColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../custom widgets/default_button.dart';
import '../custom widgets/default_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
      // text: "TunA1234@gmail.com"
      );
  TextEditingController passwordController = TextEditingController(
      // text: "TunA12345"
      );
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visible = true;
  bool valid1 = false;
  bool valid2 = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        valid1 = emailController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      if (passwordController.text.length >= 8) {
        setState(() {
          valid2 = passwordController.text.isNotEmpty;
        });
      } else {
        setState(() {
          valid2 = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future login() async {
    if (valid1 && valid2 == true) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      var snackBar = SnackBar(
        content: Text(
          "Login success",
          style: TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.successColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else if (emailController.text.trim().isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          "Please enter valid email",
          style: TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.errorColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (valid2 != true) {
      var snackBar = SnackBar(
        content: Text(
          "Please enter valid password",
          style: TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.errorColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const CustomText("Login",
                fontSize: 28, fontweight: FontWeight.w500),
            SizedBox(height: 0.8.h),
            CustomText(
              "Welcome back! Nice to see you again",
              fontSize: 16,
              fontweight: FontWeight.w400,
              textColor: AppColor.thirdFont,
            ),
            SizedBox(height: 4.4.h),
            Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: AppColor.thirdFont,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    DefaultFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      obscureText: visible == false ? false : true,
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 30,
                        color: AppColor.thirdFont,
                      ),
                      onChanged: (p0) {
                        setState(() {
                          visible = true;
                        });
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        child: Icon(
                          visible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 30,
                          color: AppColor.thirdFont,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            passwordController.text.length >= 8) {
                          // setState(() {});
                          return "please enter valid password";
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0015,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  text: "Dont’t have an account?",
                  fontSize: 14,
                  color: AppColor.thirdFont,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 0.6.w),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()
                          // detectionScreen()
                          // HomeScreen()
                          ),
                    );
                  },
                  child: DefaultText(
                    text: "Register",
                    fontSize: 14,
                    color: AppColor.lightBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            DefaultMaterialButton(
              onPressed: () {
                login();
              },
              text: "Login",
              textColor:
                  valid1 & valid2 == false ? AppColor.secFont : AppColor.white,
              fontSize: 16,
              radius: 1000,
              background: valid1 & valid2 == false
                  ? AppColor.buttonColor
                  : AppColor.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
