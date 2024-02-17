// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medbox/api/authapi.dart';
import 'package:medbox/routes.dart';
import 'package:medbox/widgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
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

  var email = "";
  var pwd = "";
  var name = "";
  var selectedGender = 'M';

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
                height: 20,
              ),
            Center(
              child: Container(
                height: 850,
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
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF24CCCC),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      "Enter Your Credentials",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    heading("Username", screenSize),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: buildTextFormField(
                        context: context,
                        hintText: "eg. Rohit Mundhra",
                        keyboardType: TextInputType.name,
                        onSaved: (p0) {
                          setState(() {
                            name = p0!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return ("Username is Mandatory");
                          } else if (value.length < 4) {
                            return ("Username must be greater than 4 Characters");
                          }
                          return null;
                        },
                      ),
                    ),
                    heading("Email", screenSize),
                    Form(
                      key: _formKey2,
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
                    heading("Gender", screenSize),
                    buildGenderRadioButtons(
                      context: context,
                      onSaved: (value) {},
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    heading("Password", screenSize),
                    Form(
                      key: _formKey3,
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return ("Password is Mandatory");
                            } else if (value.length < 6) {
                              return ("Password must be greater than 6 Characters");
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Already Have An Account? ",
                            style:
                                TextStyle(color: Colors.white60, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, MyRoutes.login);
                            },
                            child: const Text(
                              'Sign In',
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
                                  } else {
                                    bool isValid =
                                        _formKey3.currentState!.validate();
                                    if (!isValid) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    _formKey2.currentState!.save();
                                    _formKey3.currentState!.save();
                                    int result = await registerUser(name, email,
                                        pwd, selectedGender, context);
                                    if (result == 200) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                }
                                // setState(() {
                                //   isLoading = true;
                                // });
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
                                      vertical: 12, horizontal: 15),
                                  backgroundColor: const Color(0xFF24CCCC),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: isLoading
                                  ? const Text(
                                      'Creating Account.....',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    )
                                  : const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 16,
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
