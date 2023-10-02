import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/MainPage.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_formfield.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_richtext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const SignInWidget();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.blue,
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, left: 16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
              ),
              Text(
                "Log In",
                style: KTextStyle.headerTextStyle,
              )
            ],
          ),
        ),
        // CustomHeader(
        //   text: 'Log In.',
        //   onTap: () {
        //     // Navigator.pushReplacement(context,
        //     //     MaterialPageRoute(builder: (context) => const SignUp()));
        //   },
        // ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: AppColors.whiteshade,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.09),
                  child: Image.asset("assets/images/login.png"),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  headingText: "Email",
                  hintText: "Email",
                  obsecureText: false,
                  suffixIcon: const SizedBox(),
                  controller: _emailController,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomFormField(
                  headingText: "Password",
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  hintText: "At least 8 Character",
                  obsecureText: isShow,
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        isShow = !isShow;
                      }),
                  controller: _passwordController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: AppColors.blue.withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                AuthButton(
                  // onTap: () async {
                  //   User? user = await loginUsingEmailPassword(
                  //       email: _emailController.text,
                  //       password: _passwordController.text,
                  //       context: context);
                  //   if (user != null) {
                  //     // ignore: use_build_context_synchronously
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (context) => const MainPage()));
                  //   }
                  // },
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  },
                  text: 'Sign In',
                ),
                CustomRichText(
                  discription: "Don't already Have an account? ",
                  text: "Sign Up",
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpWidget()));
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Text(
    //           "Login",
    //           style: TextStyle(
    //               color: Colors.black,
    //               fontSize: 28.0,
    //               fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(
    //           height: 44.0,
    //         ),
    //         TextField(
    //           controller: _emailController,
    //           keyboardType: TextInputType.emailAddress,
    //           decoration: InputDecoration(
    //               hintText: "Email",
    //               prefixIcon: Icon(
    //                 Icons.email,
    //                 color: Colors.black,
    //               )),
    //         ),
    //         SizedBox(
    //           height: 26.0,
    //         ),
    //         TextField(
    //           controller: _passwordController,
    //           obscureText: true,
    //           decoration: InputDecoration(
    //               hintText: "Password",
    //               prefixIcon: Icon(
    //                 Icons.key,
    //                 color: Colors.black,
    //               )),
    //         ),
    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         CustomRichText(
    //           discription: "Don't already Have an account? ",
    //           text: "Sign Up",
    //           onTap: () {
    //             Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const SignUpWidget()));
    //           },
    //         ),
    //         Container(
    //           width: double.infinity,
    //           child: RawMaterialButton(
    //             fillColor: Color(0xFF0069FE),
    //             elevation: 0.0,
    //             padding: EdgeInsets.symmetric(vertical: 20.0),
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(12.0)),
    //             // onPressed: () async {
    //             //   User? user = await loginUsingEmailPassword(
    //             //       email: _emailController.text,
    //             //       password: _passwordController.text,
    //             //       context: context);
    //             //   if (user != null) {
    //             //     // ignore: use_build_context_synchronously
    //             //     Navigator.of(context).pushReplacement(
    //             //         MaterialPageRoute(
    //             //             builder: (context) => const MainPage()));
    //             //   }
    //             // },
    //             onPressed: () {
    //               Navigator.of(context).pushReplacement(MaterialPageRoute(
    //                   builder: (context) => const MainPage()));
    //             },
    //             child: const Text(
    //               "Login",
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 18.0,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ]),
    // );
  }
}

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }
  // void register(String email, password) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } catch (e) {
  //     Get.snackbar("About User", "User message",
  //         backgroundColor: Colors.redAccent,
  //         snackPosition: SnackPosition.BOTTOM,
  //         titleText: const Text(
  //           "Account creation failed",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         messageText: Text(
  //           e.toString(),
  //           style: const TextStyle(color: Colors.white),
  //         ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.blue,
          ),
          CustomHeader(
              text: 'Sign Up.',
              onTap: () {
                // AuthController.instance.register(userName, password);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.whiteshade,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09),
                    child: Image.asset("assets/images/login.png"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    headingText: "UserName",
                    hintText: "username",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    controller: _userName,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    headingText: "Email",
                    hintText: "Email",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    controller: _passwordController,
                    headingText: "Password",
                    hintText: "At least 8 Character",
                    obsecureText: true,
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility), onPressed: () {}),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AuthButton(
                    onTap: () async {
                      User? user = await registerUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      }
                    },
                    text: 'Sign Up',
                  ),
                  CustomRichText(
                    discription: 'Already Have an account? ',
                    text: 'Log In here',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
