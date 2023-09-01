class PostGetModel {
  Pagination pagination;
  final List<Post>? posts;

  PostGetModel({
    required this.pagination,
    required this.posts,
  });

  factory PostGetModel.fromJson(Map<String, dynamic> json) => PostGetModel(
    pagination: Pagination.fromJson(json["pagination"]),
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
    "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
  };
}

class Pagination {
  int pageSize;
  int nextPage;
  int length;

  Pagination({
    required this.pageSize,
    required this.nextPage,
    required this.length,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    pageSize: json["pageSize"],
    nextPage: json["nextPage"],
    length: json["length"],
  );

  Map<String, dynamic> toJson() => {
    "pageSize": pageSize,
    "nextPage": nextPage,
    "length": length,
  };
}

class Post {
  String id;
  DateTime createdAt;
  String address;
  String status;
  String type;
  String postAuthor;
  PostedBy postedBy;



  Post({
    required this.id,
    required this.createdAt,
    required this.address,
    required this.status,
    required this.postAuthor,
    required this.type,
    required this.postedBy,

  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    address: json["address"],
    status: json['status'],
    postAuthor: json['postAuthor'],
    type: json['type'],
    postedBy: PostedBy.fromJson(json["postedBy"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "address": address,
    "status": status,
    "postAuthor": postAuthor,
    "type": type,
    "postedBy": postedBy.toJson(),

  };
}


class PostedBy {
  String firstName;
  String lastName;
  String profilePicUrl;
  String userId;
  bool isDefaultImage;
  String defaultImagePath;

  PostedBy({
    required this.firstName,
    required this.lastName,
    required this.profilePicUrl,
    required this.userId,
    required this.isDefaultImage,
    required this.defaultImagePath,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    firstName: json["firstName"],
    lastName: json["lastName"],
    profilePicUrl: json["profilePicUrl"],
    userId: json["userId"],
    isDefaultImage: json["isDefaultImage"],
    defaultImagePath: json["defaultImagePath"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "profilePicUrl": profilePicUrl,
    "userId": userId,
    "isDefaultImage": isDefaultImage,
    "defaultImagePath": defaultImagePath,
  };
}