import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/bloc/login_bloc.dart';
import '../../controller/bloc/login_event.dart';
import '../../controller/bloc/login_state.dart';
import '../../model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    String email = "";
    String password = "";

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context).add(
        LoginSubmittingEvent());
    BlocProvider.of<LoginBloc>(context).add(
        LoginSubmittedEvent(
            email: email,
            password: password));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginSuccessState){
            debugPrint("Success");
            return _contactList(state.contactDetails);
          }
          else if (state is LoginLoadingState) {
            debugPrint("Loading");
          return buildLoading();
          } else if (state is LoginFailureState) {
            debugPrint("Fail");
          return _buildError();
          } else {
            return const SizedBox(child: Text("Hello"),);
          }
        }),
      ),
    );
  }

  Future<void> provide() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString('email')!;
    password = preferences.getString('password')!;
  }
}

//Widgets...
Widget buildLoading() {
  return const Center(
    child: SizedBox(
      child: CircularProgressIndicator(),
    ),
  );
}
Widget _contactList(CoupinoModel contDetails) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            String baseUrl = 'https://coupinos-app.azurewebsites.net';
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Contact Details", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  Card(
                    elevation: 5.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          height: 90,
                          width: 100,
                          child: Image.network('$baseUrl${contDetails.contactPerson.defaultImagePath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 9),
                                    child: Text("Name:- ${contDetails.contactPerson.firstName} ${contDetails.contactPerson.lastName}",
                                      style: const TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text("Email Id:- ${contDetails.contactPerson.email}",
                                    style: const TextStyle(color: Colors.blue, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text("Gender:- ${contDetails.contactPerson.gender}",
                                    style: const TextStyle(color: Colors.brown, fontSize: 15),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text("Date of Birth:- ${contDetails.contactPerson.dob.day} / ${contDetails.contactPerson.dob.month} / ${contDetails.contactPerson.dob.year}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text("Login Token:- ${contDetails.loginToken}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                 SizedBox(height: 50,),
                 Text("Address Details", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  Card(
                    child: Column(
                      children: [
                        Container(
                            child: Text("Street Details:- ${contDetails.address.street} ${contDetails.address.city}")),
                        Container(
                          child: Text("Country with Postal Code:-  ${contDetails.address.country}  ${contDetails.address.postalCode}"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    ),
  );
}

Widget _buildError() {
  return const Center(child: Text('No Data Available You have entered the wrong credentials'));
}