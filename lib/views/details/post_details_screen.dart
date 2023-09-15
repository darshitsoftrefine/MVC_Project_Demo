import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/post_get_bloc/post_details_event.dart';
import '../../controller/post_get_bloc/post_details_state.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../model/post_get_data/post_details_model.dart';
import '../../model/post_get_data/post_details_repository.dart';
import '../utils/get_location.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key});

  final baseUrl = ConstantStrings.baseUrl;
  final ValueNotifier<bool> hasData = ValueNotifier<bool>(false);
  final double latitude = 72.50369833333333;
  final double longitude = 23.034296666666666;
  final ValueNotifier<Data?> refresh = ValueNotifier<Data?> (null);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => PostDetailsBloc(repository: PostGetDetailsFetch())..add(PostDetailsSubmittingEvent()),
        child: BlocProvider(create: (context) => PostDetailsBloc(repository: PostGetDetailsFetch())..add(PostDetailsSubmittedEvent(id: '')),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text("Post Details", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, size: 24, color: Colors.black,))
          ],
        ),
        body: BlocListener<PostDetailsBloc, PostDetailsState>(
                listener: (context, state) {
                if (state is PostDetailsSuccessState) {
                debugPrint("Success25");
                 hasData.value = true;
                  refresh.value = state.postDetails;

                }
                else if (state is PostDetailsLoadingState) {
                debugPrint("Loading");

                } else if (state is PostDetailsFailureState) {
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
                  builder: (BuildContext context, Data? value, Widget? child) {
                    // Display of the List
                    return ListView.builder(
                      itemCount: 1,
                        itemBuilder: (context, index) {
                          int c = -1;
                          ++c;
                          return Padding(
                            padding: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
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
                                                      '$baseUrl${value?.postedBy?.defaultImagePath}',
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${value?.postedBy?.firstName} ${value?.postedBy?.lastName}",
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
                                              Text(calculateTime('${value?.createdAt}'), style: const TextStyle(fontSize: 10, color: Colors.grey),)
                                            ],
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(top: 9),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text('${value?.postHashTags}', style: const TextStyle(color: Colors.blue, fontSize: 12),),
                                                    const SizedBox(width: 8,),
                                                    Text("${value?.postDescription}", style: const TextStyle(color: Colors.blue, fontSize: 12)),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                    value?.postMedia?.length == 0 ? const SizedBox() :
                                    Container(
                                        margin: const EdgeInsets.only(top: 9),
                                        child: ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius: BorderRadius.circular(
                                              1),
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image.network('$baseUrl${value?.postMedia?[c].url}',
                                              fit: BoxFit.cover,),
                                          ),
                                        )),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 9),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(onPressed: () {

                                                  },
                                                      icon: value?.postLikes?.length == 0 ? const Icon(Icons.favorite_outline, color: Colors.grey, size: 25,): const Icon(Icons.favorite, color: Colors.red, size: 25,)),
                                                  value?.postLikes?.length == 0 ? SizedBox():  Text('${value?.postLikes?[0].firstName}' '${value?.postLikes?[0].lastName}' , style: TextStyle(fontSize: 12),),
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
                                 Text('${ConstantStrings.commentHeadingText}  (${value?.postComments?.length})', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                value?.postComments?.length == 0 ? Center(child: Image.asset(ConstantImages.noCommentImage, width: 180, height: 189,)) : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundImage: value?.postComments?.length == 0? NetworkImage(''): NetworkImage('${value?.postComments?[c].defaultImagePath}'),
                                        ),
                                        const SizedBox(width: 5,),
                                        Text('${value?.postComments?[c].firstName}' '${value?.postComments?[c].lastName}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(calculateTime('${value?.postComments?[c].createdAt}'), style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 24,))
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                //Text("${value?.postComments?[c].comment}")
                                TextField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red)
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: ConstantStrings.hintTextInDetails,
                                  ),
                                ),
                              ],
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
    )
    );
  }
  String calculateTime(String creation){
    Duration diff = DateTime.now().difference(DateTime.parse(creation));
    int diffyears1 = diff.inDays ~/ 365;
    int diffmonths1 = diff.inDays ~/ 30;
    int diffweeks1 = diff.inDays ~/ 7;
    int diffhours1 = diff.inDays ~/ 24;
    if(diffyears1 > 0){
      return '$diffyears1 years ago';
    } else if(diffmonths1 > 0){
      return '$diffmonths1 months ago';
    } else if(diffweeks1 > 0) {
      return '$diffweeks1 weeks ago';
    }else if(diffhours1 > 0){
      return '$diffhours1 hours ago';
    }else {
      return 'Just now';
    }
  }

  void fetchData(BuildContext context) async {
    hasData.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ids = prefs.getString('id');
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted) {
      BlocProvider.of<PostDetailsBloc>(context).add(PostDetailsSubmittingEvent());
      BlocProvider.of<PostDetailsBloc>(context).add(PostDetailsSubmittedEvent(id: '$ids'));
    }
    hasData.value = true;

  }
}
