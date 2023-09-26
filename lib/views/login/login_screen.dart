import 'package:coupinos_project/views/constants/custom_widgets.dart';
import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:coupinos_project/views/themes/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/login_bloc/login_bloc.dart';
import '../../controller/login_bloc/login_event.dart';
import '../../controller/login_bloc/login_state.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isInputValid = false;
  bool isLoad = false;
  String loginToken = "";

  void checkInput() {
    setState(() {
      isInputValid = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: kToolbarHeight + 1,
        elevation: 0.0,
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          if (state is LoginLoadingState) {
            debugPrint("Loading State");
            setState(() {
              isLoad = true;
            });
          } else if (state is LoginFailureState) {
            debugPrint("Failure State");
            if(context.mounted) {
              showDialog(context: context, builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text("You have entered the wrong credentials."),
                    actions: [
                      ElevatedButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text("Ok"))
                    ],
                  ),);
            }
            setState(() {
              isLoad = false;
            });
          } else if(state is LoginSuccessState) {
            preferences.setString('loginToken', state.contactDetails.loginToken);
            debugPrint("Success State ");
              if(context.mounted) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()));
              }
          } else {
            debugPrint("Initial State");
          }
        },
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                ConstantImages.splashBackgroundImage, fit: BoxFit.fill,),
            ),
            Positioned(
                top: 35,
                left: 110,
                //bottom: 705,
                child: Center(child: Image.asset(
                  ConstantImages.splashTextImage, width: 160,
                  height: 34,))),
            Positioned(
              top: 145,
              right: 0.1,
              left: 0.1,
              child: Container(
                padding: const EdgeInsets.only(left: 26, right: 26),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                    )
                ),
                height: MediaQuery.of(context).size.height / 1.1,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      children: [
                        const Text(ConstantStrings.loginHeading,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 22),),
                        const SizedBox(height: 10,),
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: ConstantStrings.signUpText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16)),
                            TextSpan(
                                text: ConstantStrings.signUpText2,
                                style: TextStyle(color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ]),
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(ConstantStrings.emailHeading,
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400),),
                            const SizedBox(height: 8,),
                            CustomWidgets().textField(ConstantStrings.emailHintText, emailController, checkInput, false, null),
                            const SizedBox(height: 16,),
                            const Text(ConstantStrings.passwordText,
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(height: 8,),
                            CustomWidgets().textField(ConstantStrings.passwordHintText, passwordController, checkInput, !_passwordVisible, IconButton(
                              icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ), onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            ),)
                          ],
                        ),
                        const SizedBox(height: 24,),
                        isInputValid ? isLoad ? const CircularProgressIndicator() : CustomWidgets().loginButtonAble(() async{
                          BlocProvider.of<LoginBloc>(context).add(LoginSubmittingEvent());
                           BlocProvider.of<LoginBloc>(context).add(LoginSubmittedEvent(
                            email: emailController.text,
                            password: passwordController.text)
                          );
                            },
                          isInputValid ? const Color(0xFFF8485E) : Colors.grey,) : CustomWidgets().loginButtonDisable()
                      ]
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomWidgets().loginBottomBar(),
    );
  }
}