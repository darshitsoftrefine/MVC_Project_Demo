import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:coupinos_project/views/themes/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/post_get_bloc/post_details_event.dart';
import '../../controller/post_get_bloc/post_details_state.dart';
import '../../controller/post_get_bloc/post_get_bloc.dart';
import '../../model/post_get_data/post_details_model.dart';
import '../../model/post_get_data/post_details_repository.dart';
import '../utils/get_location.dart';
import '../utils/get_time.dart';

class PostDetailsScreen extends StatelessWidget {
  final String id;
  PostDetailsScreen({super.key, required this.id});

  final baseUrl = ConstantStrings.baseUrl;
  final ValueNotifier<bool> hasData = ValueNotifier<bool>(false);
  final double latitude = 72.50369833333333;
  final double longitude = 23.034296666666666;
  final ValueNotifier<Data?> refresh = ValueNotifier<Data?>(null);
  final commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => PostDetailsBloc(repository: PostGetDetailsFetch())..add(PostDetailsSubmittingEvent()),
        child: BlocProvider(create: (context) => PostDetailsBloc(repository: PostGetDetailsFetch())..add(PostDetailsSubmittedEvent(id: id)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(ConstantStrings.postDetailsHeading, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),),
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
              return value ? ValueListenableBuilder(
                valueListenable: refresh,
                builder: (BuildContext context, Data? value, Widget? child) {
                  int c = -1;
                  ++c;
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10),
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            slivers: [
                              SliverFillRemaining(
                                fillOverscroll: true,
                                hasScrollBody: false,
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
                                                            return const SizedBox();
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(GetTime().calculateTime('${value?.createdAt}'), style: const TextStyle(fontSize: 10, color: Colors.grey),)
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
                                    value!.postMedia!.isEmpty ? const SizedBox() :
                                    Container(
                                        margin: const EdgeInsets.only(top: 9),
                                        child: ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius: BorderRadius.circular(
                                              1),
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image.network('$baseUrl${value.postMedia?[c].url}',
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
                                                      icon: value.postLikes!.isEmpty ? const Icon(Icons.favorite_outline, color: Colors.grey, size: 25,): const Icon(Icons.favorite, color: Colors.red, size: 25,)),
                                                  Text('${value.postLikes?.length}' , style: const TextStyle(fontSize: 12),),
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
                                    Text('${ConstantStrings.commentHeadingText}  (${value.postComments?.length})', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 10,),
                                    value.postComments!.isEmpty ? Center(child: Image.asset(ConstantImages.noCommentImage, width: 180, height: 189,)) : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundImage: value.postComments!.isEmpty? const NetworkImage(''): NetworkImage('$baseUrl''${value.postComments?[c].defaultImagePath}'),
                                            ),
                                            const SizedBox(width: 5,),
                                            Text('${value.postComments?[c].firstName}' '${value.postComments?[c].lastName}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(GetTime().calculateTime('${value.postComments?[c].createdAt}'), style: const TextStyle(fontSize: 10, color: Colors.grey),),
                                            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 24,))
                                          ],
                                        )
                                      ],
                                    ),
                                    value.postComments!.isEmpty? const SizedBox(): Padding(padding: const EdgeInsets.only(left: 35.0), child: Text("${value.postComments?[c].comment}"),
                                    ),
                                    const SizedBox(height: 20,),

                                    const Expanded(child: SizedBox()),

                                    ValueListenableBuilder(
                                      valueListenable: commentController,
                                      builder: (BuildContext context, value, Widget? child) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: commentController,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide:  BorderSide(color: CustomColors.primaryColor)
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  hintText: ConstantStrings.hintTextInDetails,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5,),
                                            value.text.isEmpty ? const SizedBox() :
                                            Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: CustomColors.primaryColor,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Colors.white,)))
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                  },
              ) : const Center(child: CircularProgressIndicator(),);
            },
          ),
        ),
    ),
    )
    );
  }

  void fetchData(BuildContext context) async {
    hasData.value = false;
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted) {
      BlocProvider.of<PostDetailsBloc>(context).add(PostDetailsSubmittingEvent());
      BlocProvider.of<PostDetailsBloc>(context).add(PostDetailsSubmittedEvent(id: id));
    }
    hasData.value = true;
  }
}
