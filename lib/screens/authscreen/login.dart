// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medbox/api/authapi.dart';
import 'package:medbox/routes.dart';
import 'package:medbox/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  var email = "";
  var pwd = "";

  Widget heading(title, screenSize) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1320),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (MediaQuery.of(context).size.width < 500)
              const SizedBox(
                height: 50,
              ),
            Center(
              child: Container(
                height: 650,
                width: 400,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "namedlogo",
                      child: Image.asset(
                        "assets/logos/namedlogo.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF24CCCC),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      "Enter Your Login Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Column(
                      children: [
                        heading("Email", screenSize),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: buildTextFormField(
                            context: context,
                            hintText: "example@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (p0) {
                              setState(() {
                                email = p0!;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  !value.contains('@') ||
                                  value.trim().isEmpty) {
                                return ("Enter Valid Email Address");
                              }
                              return null;
                            },
                          ),
                        ),
                        heading("Password", screenSize),
                        Form(
                          key: _formKey2,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: buildPasswordTextFormField(
                            context: context,
                            hintText: "Password",
                            keyboardType: TextInputType.text,
                            onSaved: (p0) {
                              setState(() {
                                pwd = p0!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return ("Please Enter Password");
                              }
                              return null;
                            },
                            trailingicon: GestureDetector(
                              child: _obscureText
                                  ? const Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: Color(0xFF62F4F4),
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      size: 20,
                                      color: Color(0xFF62F4F4),
                                    ),
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            obscureText: _obscureText ? true : false,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Create a new Account? ",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, MyRoutes.signup);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Color(0xFF24CCCC),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                bool isValid =
                                    _formKey.currentState!.validate();
                                if (!isValid) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                } else {
                                  bool isValid =
                                      _formKey2.currentState!.validate();
                                  if (!isValid) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  _formKey2.currentState!.save();
                                  int result =
                                      await loginUser(email, pwd, context);

                                  if (result == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Login Successful"),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                    Navigator.popAndPushNamed(
                                        context, MyRoutes.main);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }

                                // if (_searchCollegeController.text.isNotEmpty &&
                                //     _searchCollegeController.text
                                //         .trim()
                                //         .isNotEmpty &&
                                //     year.isNotEmpty &&
                                //     field.isNotEmpty &&
                                //     course.isNotEmpty) {
                                //   Map<String, dynamic> updatedData = {
                                //     'college': _searchCollegeController.text,
                                //     'year': year,
                                //     'program': field,
                                //     'course': course
                                //   };
                                //   int? response =
                                //       await User.updateUserData(updatedData);
                                //   if (response == 200) {
                                //     setState(() {
                                //       isLoading = false;
                                //     });
                                //     ScaffoldMessenger.of(context)
                                //         .showSnackBar(const SnackBar(
                                //       content:
                                //           Text("Profile Created Sucessfully"),
                                //       duration: Duration(seconds: 1),
                                //     ));
                                //     Future.delayed(const Duration(seconds: 1),
                                //         () {
                                //       Get.offNamed(MyRoutes.main);
                                //     });
                                //   } else {
                                //     setState(() {
                                //       isLoading = false;
                                //     });
                                //   }
                                // } else {
                                //   setState(() {
                                //     isLoading = false;
                                //   });
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(const SnackBar(
                                //     content: Text("All fields are Required"),
                                //     duration: Duration(seconds: 1),
                                //   ));
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  backgroundColor: const Color(0xFF24CCCC),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: isLoading
                                  ? const Text(
                                      'Signing In......',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    )
                                  : const Text(
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
