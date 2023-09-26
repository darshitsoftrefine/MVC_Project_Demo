import 'package:coupinos_project/views/constants/custom_widgets.dart';
import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:coupinos_project/views/details/post_details_screen.dart';
import 'package:coupinos_project/views/utils/get_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../controller/post_get_bloc/post_get_event.dart';
import '../../controller/post_get_bloc/post_get_state.dart';
import '../../model/post_get_data/post_get_model.dart';
import '../../model/post_get_data/post_get_repository.dart';
import '../login/login_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Posts> tempList = [];
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
            leading: Builder(
                builder: (context) => IconButton(onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu),
                  color: Colors.black,)
            ),

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
                      CustomWidgets().homeAppBarButton('Filter', 69, 32),
                      const SizedBox(width: 8,),
                      CustomWidgets().homeAppBarButton('Search', 79, 32),
                      const SizedBox(height: 30,)
                    ]
                ),
              ),
            ),
          ),
          // Drawer
          drawer:  Drawer(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 12, right: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ConstantImages.splashTextRedImage),
                          const SizedBox(width: 90,),
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close))
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                '$baseUrl${tempList[index].postedBy?.defaultImagePath}',
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${tempList[index].postedBy?.firstName} ${tempList[index].postedBy?.lastName}",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                                ),
                               FutureBuilder(
                                  future: GetEmail().getEmail(),
                                 builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                  if (snapshot.hasData) {
                                  return Text(snapshot.data!, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),);
                                  } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                  } else {
                                  return const SizedBox();
                                   }
                                  },
                               )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                     CustomWidgets().homeDrawer(),
                          GestureDetector(
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove('loginToken');
                              if(context.mounted) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginScreen()));
                              }
                            },
                            child: const ListTile(
                              leading: Icon(Icons.logout, color: Colors.red,),
                              title: Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16),),
                            ),
                          )
                    ],
                  );
                },
              ),
            ),
          ),
          body: BlocBuilder<PostGetBloc, PostGetState>(
            builder: (context, state) {
              if (state is PostGetSuccessState) {
              debugPrint("Success");
              hasData.value = true;
              refresh.value = state.postDetails;
              tempList = state.postDetails;
              return _showList(tempList);
              }
              else if (state is PostGetLoadingState) {
                debugPrint("Loading");
                return _buildLoading();

              } else if (state is PostGetFailureState) {
                debugPrint("Fail");
                return _buildError();
              } else {
               return _buildLoading();
              }
            },
          ),
          )
        )
    );
  }

  Widget _showList(List<Posts> tempList){
    return ValueListenableBuilder(
      valueListenable: hasData,

      builder: (BuildContext context, value, Widget? child) {
        return value ? RefreshIndicator(onRefresh: ()async{
          fetchData(context);
        }, child: ValueListenableBuilder(
          valueListenable: refresh,

          builder: (BuildContext context, List<Posts> value, Widget? child) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: tempList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        // Id store for details screen
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen(id: '${tempList[index].sId}')),
                        );
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
                                              '$baseUrl${tempList[index].postedBy?.defaultImagePath}',
                                            ),
                                          ),
                                          const SizedBox(width: 8,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${tempList[index].postedBy?.firstName} ${tempList[index].postedBy?.lastName}",
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
                                                    return const SizedBox();
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(GetTime().calculateTime('${tempList[index].createdAt}'), style: const TextStyle(fontSize: 10, color: Colors.grey),),
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
                                            Text('${tempList[index].postHashTags}', style: const TextStyle(color: Colors.blue, fontSize: 12),),
                                            const SizedBox(width: 8,),
                                            Text("${tempList[index].postDescription}", style: const TextStyle(color: Colors.blue, fontSize: 12)),
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
                                tempList[index].postMedia!.isEmpty ? const SizedBox() :
                                Container(
                                    margin: const EdgeInsets.only(top: 9),
                                    child: ClipRRect(
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(
                                          1),
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.network('$baseUrl${tempList[index].postMedia?[0].url}',
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
                                              icon: tempList[index].postLikes!.isEmpty ? const Icon(Icons.favorite_border_outlined, color: Colors.grey , size: 25,): const Icon(Icons.favorite, color: Colors.red, size: 25,)),
                                          Text('${tempList[index].postLikes?.length}'),
                                          IconButton(onPressed: () {}, icon: const Icon(Icons.messenger_outline, color: Colors.grey,)),
                                          tempList[index].postBookmarks?.length == null ? const Text("0") :Text('${tempList[index].postBookmarks?.length}'),
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
        ),): const Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _buildLoading(){
   return const Center(
     child: CircularProgressIndicator(),
   );
  }

  Widget _buildError() {
    return const Center(child: Text('No Data Available'));
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
}