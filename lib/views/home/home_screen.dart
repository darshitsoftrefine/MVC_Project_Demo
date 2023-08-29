import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  late LoginBloc loginBloc;


  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.add(FetchLoginEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginInitialState) {
          return buildLoading();
          } else if (state is LoginLoadingState) {
          return buildLoading();
          } else if (state is LoginLoadedState) {
          return _contactList(state.contDetails);
          } else if (state is LoginErrorState) {
          return _buildError();
          } else {
          return _buildError();
          }
        }),
      ),
    );
  }
}

//Widgets...
Widget buildLoading() {
  return Center(
    child: SizedBox(
      child: Column(
        children: const [
          CircularProgressIndicator(),
          Text('Please Wait for a Minute', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
        ],
      ),
    ),
  );
}

Widget _contactList(ContactPerson contDetails) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            String baseUrl = 'https://coupinos-app.azurewebsites.net';
            return Column(
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
                        child: Image.network('$baseUrl${contDetails.defaultImagePath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(top: 9),
                                  child: Text("Name:- ${contDetails.firstName} ${contDetails.lastName}",
                                    style: const TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("Email Id:- ${contDetails.email}",
                                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("Gender:- ${contDetails.gender}",
                                  style: const TextStyle(color: Colors.brown, fontSize: 15),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("Date of Birth:- "+
                                    '${contDetails.dob.day}'+"/"+'${contDetails.dob.month}'+"/"+'${contDetails.dob.year}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            );
          }),
    ),
  );
}

Widget _buildError() {
  return const Center(child: Text('No Data Available'));
}