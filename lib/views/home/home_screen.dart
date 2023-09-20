import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:coupinos_project/views/details/post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../controller/post_get_bloc/post_get_event.dart';
import '../../controller/post_get_bloc/post_get_state.dart';
import '../../model/post_get_data/post_get_model.dart';
import '../../model/post_get_data/post_get_repository.dart';
import '../themes/custom_themes.dart';
import '../utils/get_location.dart';
import '../utils/get_time.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String loginToken = "";
  final int radius = 10;
  final int pageSize = 10;
  final int page = 0;
  final double latitude = 72.50369833333333;
  final double longitude = 23.034296666666666;
  final String baseUrl = ConstantStrings.baseUrl;
  final ValueNotifier<bool> hasData = ValueNotifier<bool>(false);
  final ValueNotifier<List<Posts>> refresh = ValueNotifier<List<Posts>>([]);
  final ValueNotifier<String> local = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => PostGetBloc(repository: PostGetFetch())..add(PostGetSubmittingEvent()),
      child: BlocProvider(create: (context) => PostGetBloc(repository: PostGetFetch())..add(PostGetSubmittedEvent(loginToken: loginToken, radius: radius, pageSize: pageSize, page: page, longitude: longitude, latitude: latitude)),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          //App Bar
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(ConstantImages.splashTextRedImage, width: 103,
                height: 23,
                fit: BoxFit.fitWidth,),
            ),
            leading: IconButton(onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.black,),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 10, top: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40,),
                      ElevatedButton.icon(onPressed: () {

                      },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(159, 32),
                          backgroundColor: CustomColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                            side: const BorderSide(width: 1, color: Colors.red),
                          ),
                        ),
                        icon: const Icon(Icons.assistant_navigation, size: 19,),
                        label: const Text(
                          "Nearby (25km)", style: TextStyle(color: Colors.white,
                            fontSize: 14),),
                      ),
                      const SizedBox(width: 8,),
                      ElevatedButton(onPressed: () {

                      }, style: ElevatedButton.styleFrom(
                        fixedSize: const Size(69, 32),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                          side: const BorderSide(width: 1, color: Colors.red),
                        ),
                      ),
                        child: const Text(
                          "Filter", style: TextStyle(color: Colors.red,
                            fontSize: 14),),
                      ),
                      const SizedBox(width: 8,),
                      ElevatedButton(onPressed: () {

                      }, style: ElevatedButton.styleFrom(
                        fixedSize: const Size(79, 32),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                          side: const BorderSide(width: 1, color: Colors.red),
                        ),
                      ),
                        child: const Text(
                          "Search", style: TextStyle(color: Colors.red,
                            fontSize: 14),),
                      ),
                      const SizedBox(height: 30,)
                    ]
                ),
              ),
            ),
          ),
          body: BlocListener<PostGetBloc, PostGetState>(
            listener: (context, state) {
              if (state is PostGetSuccessState) {
                debugPrint("Success");
                hasData.value = true;
                refresh.value = state.postDetails;
              }
              else if (state is PostGetLoadingState) {
                debugPrint("Loading");

              } else if (state is PostGetFailureState) {
                debugPrint("Fail");
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed")));
              } else {
                debugPrint("Loading");
                const Center(child: CircularProgressIndicator(),);
              }
            },
            child: ValueListenableBuilder(
              valueListenable: hasData,
              builder: (BuildContext context, value, Widget? child) {
                return value ? RefreshIndicator(
                  onRefresh: () async{
                    fetchData(context);
                  },
                  child: ValueListenableBuilder(
                    valueListenable: refresh,
                    builder: (BuildContext context, List<Posts> value, Widget? child) {
                      // Display of the List
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: ()async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('id', '${value[index].sId}');
                                  if(context.mounted) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen()),
                                    );
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14.0, top: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundImage: NetworkImage(
                                                      '$baseUrl${value[index].postedBy?.defaultImagePath}',
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${value[index].postedBy?.firstName} ${value[index].postedBy?.lastName}",
                                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                      ),
                                                      const SizedBox(height: 2,),
                                                      FutureBuilder<String?>(
                                                        future: GetLocation().getAddressFromLatLng(latitude, longitude),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasData) {
                                                            return Text(snapshot.data!, style: const TextStyle(fontSize: 10),);
                                                          } else if (snapshot.hasError) {
                                                            return Text(snapshot.error.toString());
                                                          } else {
                                                            return const CircularProgressIndicator();
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                                Row(
                                                  children: [
                                                    Text(GetTime().calculateTime('${value[index].createdAt}'), style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 24,))
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(top: 9),
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text('${value[index].postHashTags}', style: const TextStyle(color: Colors.blue, fontSize: 12),),
                                                      const SizedBox(width: 8,),
                                                      Text("${value[index].postDescription}", style: const TextStyle(color: Colors.blue, fontSize: 12)),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          value[index].postMedia!.isEmpty ? const SizedBox() :
                                          Container(
                                              margin: const EdgeInsets.only(top: 9),
                                              child: ClipRRect(
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius: BorderRadius.circular(
                                                    1),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Image.network('$baseUrl${value[index].postMedia?[0].url}',
                                                    fit: BoxFit.cover,),
                                                ),
                                              )),
                                          Container(
                                            margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(onPressed: () {

                                                    },
                                                        icon: value[index].postLikes!.isEmpty ?  const Icon(Icons.favorite_border_outlined, color: Colors.grey ,  size: 25,):  const Icon(Icons.favorite, color: Colors.red, size: 25,)),
                                                    Text('${value[index].postLikes?.length}'),
                                                    IconButton(onPressed: () {}, icon: const Icon(Icons.messenger_outline, color: Colors.grey,)),
                                                    value[index].postBookmarks?.length == null ? const Text("0") :Text('${value[index].postBookmarks?.length}'),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(onPressed: () {},
                                                        icon: const Icon(Icons.bookmark_border, color: Colors.grey,)),
                                                    IconButton(onPressed: () {},
                                                        icon: const Icon(Icons.file_upload_outlined, color: Colors.grey,)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ) : const Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ),
      ),
    );
  }



  void fetchData(BuildContext context) async {
    hasData.value = false;
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted) {
      BlocProvider.of<PostGetBloc>(context).add(PostGetSubmittingEvent());
      BlocProvider.of<PostGetBloc>(context).add(PostGetSubmittedEvent(loginToken: loginToken, radius: radius, pageSize: pageSize, page: page, longitude: longitude, latitude: latitude));
    }
    hasData.value = true;

  }

  void temporaryList(){

  }
}