import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isInputValid = false;


  void checkInput() {
    setState(() {
      isInputValid = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }


  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 1,
        elevation: 0.0,
        backgroundColor: const Color(0xFFF8485E),
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(ConstantImages.splashBackgroundImage, fit: BoxFit.fill,),
              ),
              Positioned(
                top: 35,
                left: 110,
                //bottom: 705,
                  child: Center(child: Image.asset(ConstantImages.splashTextImage, width: 160, height: 34,))),
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
                          const Text(ConstantStrings.loginHeading, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),),
                          const SizedBox(height: 10,),
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: ConstantStrings.signUpText,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                              TextSpan(
                                  text: ConstantStrings.signUpText2,
                                  style: TextStyle( color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16)),
                            ]),
                          ),
                          const SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(ConstantStrings.emailHeading, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              const SizedBox(height: 8,),
                              TextFormField(
                                onChanged: (value){
                                  checkInput();
                                },
                                enabled: true,
                                style: const TextStyle(color: Colors.black),
                                controller: emailController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  //labelText: label, labelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
                                  fillColor: Colors.grey,
                                  hintText: ConstantStrings.emailHintText,
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.black,
                                        style: BorderStyle.solid
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16,),
                              const Text(ConstantStrings.passwordText, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                              const SizedBox(height: 8,),
                              TextFormField(
                                onChanged: (value){
                                  checkInput();
                                },
                                enabled: true,
                                style: const TextStyle(color: Colors.black),
                                controller: passwordController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ), onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: ConstantStrings.passwordHintText,
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.black,
                                        style: BorderStyle.solid
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24,),
                          ElevatedButton(onPressed: ()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('email', emailController.text);
                            prefs.setString('password', passwordController.text);
                            if(context.mounted) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (
                                      context) => const HomeScreen()));
                            }},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: isInputValid ? const Color(0xFFF8485E) : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  fixedSize: const Size(393, 48)
                              ),
                              child: const Text(ConstantStrings.buttonText)),
                          const SizedBox(height: 500,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 80, right: 16, top: 10),
        child: Container(
          color: Colors.white,
            child: const Text(ConstantStrings.bottomText, style: TextStyle(color: Color(0xFFF8485E), fontWeight: FontWeight.w600, fontSize: 14),)),
      ),
    );
  }
}
