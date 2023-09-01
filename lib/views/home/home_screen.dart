import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../controller/post_get_bloc/post_get_event.dart';
import '../../controller/post_get_bloc/post_get_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    String loginToken = "";

  @override
  void initState() {
    BlocProvider.of<PostGetBloc>(context).add(
        PostGetSubmittingEvent());
    BlocProvider.of<PostGetBloc>(context).add(
        PostGetSubmittedEvent(loginToken: loginToken));
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
        child: BlocBuilder<PostGetBloc, PostGetState>(builder: (context, state) {
          if (state is PostGetSuccessState){
            debugPrint("Success");
            return _postList(state.postDetails);
          }
          else if (state is PostGetLoadingState) {
            debugPrint("Loading");
          return buildLoading();
          } else if (state is PostGetFailureState) {
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
    loginToken = preferences.getString('loginToken')!;
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
Widget _postList(postDetails) {
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
                  const Text("Post Details", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 90,
                            width: 100,
                            child: Image.network('$baseUrl${postDetails[index].postedBy.defaultImagePath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(top: 9),
                                      child: Text("Name:- ${postDetails[index].postedBy.firstName} ${postDetails[index].postedBy.lastName}",
                                        style: const TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 9),
                                    child: Text("Email Id:- ${postDetails[index].postedBy.userId}",
                                      style: const TextStyle(color: Colors.blue, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 9),
                                      child: Text("Address:- ${postDetails[index].address}",
                                        style: const TextStyle(
                                            fontSize: 18,),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 9),
                                      child: Text("Created at:- ${postDetails[index].createdAt.day} / ${postDetails[index].createdAt.month} / ${postDetails[index].createdAt.year}",
                                        style: const TextStyle(
                                          fontSize: 18,),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 9),
                                    child: Row(
                                      children: [
                                        const Text("Status:-"),
                                        const SizedBox(width: 10,),
                                        const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 5,
                                        ),
                                        const SizedBox(width: 5,),
                                        Text('${postDetails[index].status}')
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                 const SizedBox(height: 50,),
                ],
              ),
            );
          }),
    ),
  );
}

Widget _buildError() {
  return const Center(child: Text('No Data Available'));
}