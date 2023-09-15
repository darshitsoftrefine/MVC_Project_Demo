import 'package:coupinos_project/model/post_get_data/post_get_model.dart';

class PostDetailsModel {
  String? status;
  String? message;
  Data? data;

  PostDetailsModel({this.status, this.message, this.data});

  PostDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? createdAt;
  bool? isAdvertorialPost;
  bool? isBookmarkedByMe;
  bool? isLikedByMe;
  bool? isSharedPost;
  String? address;
  Loc? loc;
  String? postDescription;
  String? postHashTags;
  List<PostMedia>? postMedia;
  List<PostComments>? postComments;
  List<PostLikes>? postLikes;
  List? postBookmarks;
  PostedBy? postedBy;
  ShareDetails? shareDetails;
  bool? isReported;
  List? reportId;
  String? fontColor;
  String? backgroundColor;
  String? type;
  bool? commentAllowed;
  String? partnerId;
  String? status;
  String? postAuthor;
  String? zipCode;

  Data(
      {this.sId,
        this.createdAt,
        this.isAdvertorialPost,
        this.isBookmarkedByMe,
        this.isLikedByMe,
        this.isSharedPost,
        this.address,
        this.loc,
        this.postDescription,
        this.postHashTags,
        this.postMedia,
        this.postComments,
        this.postLikes,
        this.postBookmarks,
        this.postedBy,
        this.shareDetails,
        this.isReported,
        this.reportId,
        this.fontColor,
        this.backgroundColor,
        this.type,
        this.commentAllowed,
        this.partnerId,
        this.status,
        this.postAuthor,
        this.zipCode});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    isAdvertorialPost = json['isAdvertorialPost'];
    isBookmarkedByMe = json['isBookmarkedByMe'];
    isLikedByMe = json['isLikedByMe'];
    isSharedPost = json['isSharedPost'];
    address = json['address'];
    loc = json['loc'] != null ? Loc.fromJson(json['loc']) : null;
    postDescription = json['postDescription'];
    postHashTags = json['postHashTags'];
    if (json['postMedia'] != null) {
      postMedia = [];
      json['postMedia'].forEach((v) {
        postMedia!.add(PostMedia.fromJson(v));
      });
    }
    if (json['postComments'] != null) {
      postComments = <PostComments>[];
      json['postComments'].forEach((v) {
        postComments!.add(PostComments.fromJson(v));
      });
    }
    if (json['postLikes'] != null) {
      postLikes = <PostLikes>[];
      json['postLikes'].forEach((v) {
        postLikes!.add(PostLikes.fromJson(v));
      });
    }
    // if (json['postBookmarks'] != null) {
    //   postBookmarks = <Null>[];
    //   json['postBookmarks'].forEach((v) {
    //     postBookmarks!.add(new Null.fromJson(v));
    //   });
    // }
    postedBy = json['postedBy'] != null
        ? PostedBy.fromJson(json['postedBy'])
        : null;
    shareDetails = json['shareDetails'] != null
        ? ShareDetails.fromJson(json['shareDetails'])
        : null;
    isReported = json['isReported'];
    // if (json['reportId'] != null) {
    //   reportId = <Null>[];
    //   json['reportId'].forEach((v) {
    //     reportId!.add(new Null.fromJson(v));
    //   });
    // }
    fontColor = json['fontColor'];
    backgroundColor = json['backgroundColor'];
    type = json['type'];
    commentAllowed = json['commentAllowed'];
    partnerId = json['partnerId'];
    status = json['status'];
    postAuthor = json['postAuthor'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['isAdvertorialPost'] = isAdvertorialPost;
    data['isBookmarkedByMe'] = isBookmarkedByMe;
    data['isLikedByMe'] = isLikedByMe;
    data['isSharedPost'] = isSharedPost;
    data['address'] = address;
    if (loc != null) {
      data['loc'] = loc!.toJson();
    }
    data['postDescription'] = postDescription;
    data['postHashTags'] = postHashTags;
    if (this.postMedia != null) {
      data['postMedia'] = this.postMedia!.map((v) => v.toJson()).toList();
    }
    if (postComments != null) {
      data['postComments'] = postComments!.map((v) => v.toJson()).toList();
    }
    if (postLikes != null) {
      data['postLikes'] = postLikes!.map((v) => v.toJson()).toList();
    }
    // if (this.postBookmarks != null) {
    //   data['postBookmarks'] =
    //       this.postBookmarks!.map((v) => v.toJson()).toList();
    // }
    if (postedBy != null) {
      data['postedBy'] = postedBy!.toJson();
    }
    if (shareDetails != null) {
      data['shareDetails'] = shareDetails!.toJson();
    }
    data['isReported'] = isReported;
    // if (this.reportId != null) {
    //   data['reportId'] = this.reportId!.map((v) => v.toJson()).toList();
    // }
    data['fontColor'] = fontColor;
    data['backgroundColor'] = backgroundColor;
    data['type'] = type;
    data['commentAllowed'] = commentAllowed;
    data['partnerId'] = partnerId;
    data['status'] = status;
    data['postAuthor'] = postAuthor;
    data['zipCode'] = zipCode;
    return data;
  }
}

class Loc {
  String? type;
  List<double>? coordinates;

  Loc({this.type, this.coordinates});

  Loc.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class PostComments {
  String? sId;
  String? comment;
  String? createdAt;
  List? replyComment;
  List? reportId;
  String? firstName;
  String? lastName;
  String? profilePicUrl;
  bool? isDefaultImage;
  String? defaultImagePath;

  PostComments(
      {this.sId,
        this.comment,
        this.createdAt,
        this.replyComment,
        this.reportId,
        this.firstName,
        this.lastName,
        this.profilePicUrl,
        this.isDefaultImage,
        this.defaultImagePath});

  PostComments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    // if (json['replyComment'] != null) {
    //   replyComment = <Null>[];
    //   json['replyComment'].forEach((v) {
    //     replyComment!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['reportId'] != null) {
    //   reportId = <Null>[];
    //   json['reportId'].forEach((v) {
    //     reportId!.add(new Null.fromJson(v));
    //   });
    // }
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicUrl = json['profilePicUrl'];
    isDefaultImage = json['isDefaultImage'];
    defaultImagePath = json['defaultImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    // if (this.replyComment != null) {
    //   data['replyComment'] = this.replyComment!.map((v) => v.toJson()).toList();
    // }
    // if (this.reportId != null) {
    //   data['reportId'] = this.reportId!.map((v) => v.toJson()).toList();
    // }
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicUrl'] = profilePicUrl;
    data['isDefaultImage'] = isDefaultImage;
    data['defaultImagePath'] = defaultImagePath;
    return data;
  }
}

class PostLikes {
  String? sId;
  String? firstName;
  String? lastName;
  String? profilePicUrl;
  String? createdAt;

  PostLikes(
      {this.sId,
        this.firstName,
        this.lastName,
        this.profilePicUrl,
        this.createdAt});

  PostLikes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicUrl = json['profilePicUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicUrl'] = profilePicUrl;
    data['createdAt'] = createdAt;
    return data;
  }
}

class PostedBy {
  String? firstName;
  String? lastName;
  String? profilePicUrl;
  String? userId;
  bool? isDefaultImage;
  String? defaultImagePath;

  PostedBy(
      {this.firstName,
        this.lastName,
        this.profilePicUrl,
        this.userId,
        this.isDefaultImage,
        this.defaultImagePath});

  PostedBy.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicUrl = json['profilePicUrl'];
    userId = json['userId'];
    isDefaultImage = json['isDefaultImage'];
    defaultImagePath = json['defaultImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicUrl'] = profilePicUrl;
    data['userId'] = userId;
    data['isDefaultImage'] = isDefaultImage;
    data['defaultImagePath'] = defaultImagePath;
    return data;
  }
}

class ShareDetails {
  String? originalPostId;
  String? sharedOn;
  SharedBy? sharedBy;

  ShareDetails({this.originalPostId, this.sharedOn, this.sharedBy});

  ShareDetails.fromJson(Map<String, dynamic> json) {
    originalPostId = json['originalPostId'];
    sharedOn = json['sharedOn'];
    sharedBy = json['sharedBy'] != null
        ? SharedBy.fromJson(json['sharedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['originalPostId'] = originalPostId;
    data['sharedOn'] = sharedOn;
    if (sharedBy != null) {
      data['sharedBy'] = sharedBy!.toJson();
    }
    return data;
  }
}

class SharedBy {
  String? firstName;
  String? lastName;
  String? profilePicUrl;

  SharedBy({this.firstName, this.lastName, this.profilePicUrl});

  SharedBy.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicUrl = json['profilePicUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicUrl'] = profilePicUrl;
    return data;
  }
}

class PostMedia {
  String? sId;
  String? mediaType;
  String? url;

  PostMedia({this.sId, this.mediaType, this.url});

  PostMedia.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mediaType = json['mediaType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mediaType'] = mediaType;
    data['url'] = url;
    return data;
  }
}
