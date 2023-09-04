import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../controller/post_get_bloc/post_get_event.dart';
import '../../controller/post_get_bloc/post_get_state.dart';
import '../../model/post_get_data/post_get_model.dart';
import '../themes/custom_themes.dart';

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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(ConstantImages.splashTextRedImage,  width: 103, height: 23, fit: BoxFit.fitWidth,),
        ),
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu), color: Colors.black,),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 10, top: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40,),
                  ElevatedButton.icon(onPressed: (){

                  },   style: ElevatedButton.styleFrom(
                    fixedSize: const Size(159, 32),
                    backgroundColor: CustomColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(width: 1, color: Colors.red),
                    ),
                  ),
                    icon: const Icon(Icons.send, size: 19,), label: const Text("Nearby (10km)", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),
                  const SizedBox(width: 8,),
                  ElevatedButton(onPressed: (){

                  },   style: ElevatedButton.styleFrom(
                    fixedSize: const Size(69, 32),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(width: 1, color: Colors.red),
                    ),
                  ),
                    child: const Text("Filter", style: TextStyle(color: Colors.red, fontSize: 14),),
                  ),
                  const SizedBox(width: 8,),
                  ElevatedButton(onPressed: (){

                  },   style: ElevatedButton.styleFrom(
                    fixedSize: const Size(79, 32),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(width: 1, color: Colors.red),
                    ),
                  ),
                    child: const Text("Search", style: TextStyle(color: Colors.red, fontSize: 14),),
                  ),
                  const SizedBox(height: 30,)
                ]
            ),
          ),
        ),
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
Widget _postList(List<Posts> postDetails) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: postDetails.length,
          itemBuilder: (context, index) {
            String baseUrl = 'https://coupinos-app.azurewebsites.net';
            int c = -1;
            ++c;
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start  ,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage('$baseUrl${postDetails[index].postedBy?.defaultImagePath}',
                            ),
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${postDetails[index].postedBy?.firstName} ${postDetails[index].postedBy?.lastName}",
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 2,),
                                Text("Hello", style: TextStyle(fontSize: 10),),
                              ],
                            ),
                            const SizedBox(width: 145,),
                            Text("2h ago", style: TextStyle(fontSize: 12, color: Colors.grey.shade500),),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, size: 24,))
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 9),
                            child: Row(
                              children: const [
                                Text("#hashtag", style: TextStyle(color: Colors.blue, fontSize: 12),),
                                SizedBox(width: 8,),
                                Text("#newwxperience",  style: TextStyle(color: Colors.blue, fontSize: 12)),
                                SizedBox(width: 8,),
                                Text("#newlocation",  style: TextStyle(color: Colors.blue, fontSize: 12))
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          postDetails[index].postMedia!.isEmpty ? const SizedBox(width: 311, height: 213):
                          Stack(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(top: 9),
                                  child: Image.network('$baseUrl${postDetails[index].postMedia?[c].url}',
                                    width: 331, height: 213,
                                    fit: BoxFit.fill,)),
                              Positioned(
                                top: 199,
                                  left: 170,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircleAvatar(backgroundColor: Colors.red, radius: 4,),
                                      SizedBox(width: 4,),
                                      CircleAvatar(backgroundColor: Colors.grey,radius: 3,),
                                      SizedBox(width: 4,),
                                      CircleAvatar(backgroundColor: Colors.grey,radius: 3,),
                                      SizedBox(width: 4,),
                                      CircleAvatar(backgroundColor: Colors.grey,radius: 3,),
                                      SizedBox(width: 4,),
                                      CircleAvatar(backgroundColor: Colors.grey,radius: 3,)
                                    ],
                                  ))
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){}, icon: const Icon(Icons.favorite, color: Colors.red, size: 25,)),
                                      Text("22"),
                                      IconButton(onPressed: (){}, icon: const Icon(Icons.messenger_outline, color: Colors.grey,)),
                                      const Text("3"),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 91,),
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark_border, color: Colors.grey,)),
                                      IconButton(onPressed: (){}, icon: const Icon(Icons.file_upload_outlined, color: Colors.grey,)),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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