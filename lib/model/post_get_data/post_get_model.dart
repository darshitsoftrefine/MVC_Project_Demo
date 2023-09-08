class PostGetModel {
  Pagination? pagination;
  List<Posts>? posts;

  PostGetModel({this.pagination, this.posts});

  PostGetModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? pageSize;
  int? nextPage;
  int? length;
  int? totalCount;

  Pagination({this.pageSize, this.nextPage, this.length, this.totalCount});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageSize = json['pageSize'];
    nextPage = json['nextPage'];
    length = json['length'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageSize'] = pageSize;
    data['nextPage'] = nextPage;
    data['length'] = length;
    data['totalCount'] = totalCount;
    return data;
  }
}

class Posts {
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
  List<void>? postComments;
  List<PostLikes>? postLikes;
  List<void>? postBookmarks;
  PostedBy? postedBy;
  ShareDetails? shareDetails;
  bool? isReported;
  List<void>? reportId;
  String? fontColor;
  String? backgroundColor;
  String? type;
  bool? commentAllowed;
  String? partnerId;
  String? status;
  String? postAuthor;
  String? zipCode;
  String? category;
  String? dataPrivacyRule;

  Posts(
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
        this.zipCode,
        this.category,
        this.dataPrivacyRule});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt =  json["createdAt"];
    isAdvertorialPost = json['isAdvertorialPost'];
    isBookmarkedByMe = json['isBookmarkedByMe'];
    isLikedByMe = json['isLikedByMe'];
    isSharedPost = json['isSharedPost'];
    address = json['address'];
    loc = json['loc'] != null ? Loc.fromJson(json['loc']) : null;
    postDescription = json['postDescription'];
    postHashTags = json['postHashTags'];
    if (json['postMedia'] != null) {
      postMedia = <PostMedia>[];
      json['postMedia'].forEach((v) {
        postMedia!.add(PostMedia.fromJson(v));
      });
    }
    if (json['postLikes'] != null) {
      postLikes = <PostLikes>[];
      json['postLikes'].forEach((v) {
        postLikes!.add(PostLikes.fromJson(v));
      });
    }
    postedBy = json['postedBy'] != null
        ? PostedBy.fromJson(json['postedBy'])
        : null;
    shareDetails = json['shareDetails'] != null
        ? ShareDetails.fromJson(json['shareDetails'])
        : null;
    isReported = json['isReported'];
    fontColor = json['fontColor'];
    backgroundColor = json['backgroundColor'];
    type = json['type'];
    commentAllowed = json['commentAllowed'];
    partnerId = json['partnerId'];
    status = json['status'];
    postAuthor = json['postAuthor'];
    zipCode = json['zipCode'];
    category = json['category'];
    dataPrivacyRule = json['dataPrivacyRule'];
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
    if (postMedia != null) {
      data['postMedia'] = postMedia!.map((v) => v.toJson()).toList();
    }
    if (postLikes != null) {
      data['postLikes'] = postLikes!.map((v) => v.toJson()).toList();
    }
    if (postedBy != null) {
      data['postedBy'] = postedBy!.toJson();
    }
    if (shareDetails != null) {
      data['shareDetails'] = shareDetails!.toJson();
    }
    data['isReported'] = isReported;

    data['fontColor'] = fontColor;
    data['backgroundColor'] = backgroundColor;
    data['type'] = type;
    data['commentAllowed'] = commentAllowed;
    data['partnerId'] = partnerId;
    data['status'] = status;
    data['postAuthor'] = postAuthor;
    data['zipCode'] = zipCode;
    data['category'] = category;
    data['dataPrivacyRule'] = dataPrivacyRule;
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

class PostLikes {
  String? sId;
  String? firstName;
  String? lastName;
  String? profilePicUrl;
  bool? isDefaultImage;
  String? defaultImagePath;
  String? createdAt;

  PostLikes(
      {this.sId,
        this.firstName,
        this.lastName,
        this.profilePicUrl,
        this.isDefaultImage,
        this.defaultImagePath,
        this.createdAt});

  PostLikes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicUrl = json['profilePicUrl'];
    isDefaultImage = json['isDefaultImage'];
    defaultImagePath = json['defaultImagePath'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicUrl'] = profilePicUrl;
    data['isDefaultImage'] = isDefaultImage;
    data['defaultImagePath'] = defaultImagePath;
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