import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../controller/post_get_bloc/post_get_event.dart';
import '../../controller/post_get_bloc/post_get_state.dart';
import '../../model/post_get_data/post_get_model.dart';
import '../../model/post_get_data/post_get_repository.dart';
import '../themes/custom_themes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String loginToken = "";
  final int radius = 10;
  final int pageSize = 10;
  final int page = 0;
  final double latitude = 72.50369833333333;
  final double longitude = 23.034296666666666;
  final ValueNotifier<bool> hasData = ValueNotifier<bool>(false);
  final ValueNotifier<List<Posts>> refresh = ValueNotifier<List<Posts>>([]);
  final ValueNotifier<String> local = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => PostGetBloc(repository: PostGetFetch())..add(PostGetSubmittingEvent()),
      child: BlocProvider(create: (context) => PostGetBloc(repository: PostGetFetch())..add(PostGetSubmittedEvent(loginToken: loginToken, radius: radius, pageSize: pageSize, page: page, longitude: longitude, latitude: latitude)),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocListener<PostGetBloc, PostGetState>(
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
                        return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              String baseUrl = ConstantStrings.baseUrl;
                              int c = -1;
                              ++c;
                              List<double>? lat = value[index].loc?.coordinates;
                              double latitude = lat![0];
                              double longitude = lat[1];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
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
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [Row(
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
                                                        future: getAddressFromLatLng(latitude, longitude), // pass the future function here
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
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text("2h ago", style: TextStyle(fontSize: 12, color: Colors.grey.shade500),),
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
                                                  child: Image.network('$baseUrl${value[index].postMedia?[c].url}',
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
                                                        icon: const Icon(Icons.favorite, color: Colors.red, size: 25,)),
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
      ),
    );
  }

  Future<String?> getAddressFromLatLng(double latitude,
      double longitude) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          longitude, latitude);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        local.value = '${place.street} ${place.locality} ${place.postalCode} ${place.country}';
        return '${place.street} ${place.locality} ${place.postalCode} ${place.country}';   //concat  locality postalcode  country
      } else {
        return 'Location not found';
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
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