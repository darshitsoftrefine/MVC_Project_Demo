import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Color(0xFFF8485E),
      //   leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
      // ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(ConstantImages.splashBackgroundImage, fit: BoxFit.fill,),
            ),
            Positioned(
              top: 65,
              left: 120,
              bottom: 645,
                child: Center(child: Image.asset(ConstantImages.splashTextImage, width: 160, height: 34,))),
            Positioned(
              top: 215,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)
                    )
                  ),
                  height: MediaQuery.of(context).size.height / 1.1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
                    //fillOverscroll: true,
                    //hasScrollBody: false,
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 250),
                    //alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            //CustomField(label: "muster@muster.de", control: emailController, obs: false, hint: 'muster@muster.de ',),
                            const SizedBox(height: 16,),
                            const Text(ConstantStrings.passwordText, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                            const SizedBox(height: 8,),
                            TextFormField(
                              enabled: true,
                              style: const TextStyle(color: Colors.black),
                              controller: passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
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
                                //labelText: label, labelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
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
                        ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: emailController.text == '' && passwordController == '' ? Colors.red : Colors.grey,
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                fixedSize: const Size(393, 48)
                            ),
                            child: const Text(ConstantStrings.buttonText))
                      ],
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 85, right: 16),
        child: Container(
          color: Colors.white,
            child: const Text(ConstantStrings.bottomText, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14),)),
      ),
    );
  }
}
