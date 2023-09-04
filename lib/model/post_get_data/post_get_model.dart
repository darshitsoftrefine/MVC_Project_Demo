class PostGetModel {
  Pagination? pagination;
  List<Posts>? posts;

  PostGetModel({this.pagination, this.posts});

  PostGetModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageSize'] = this.pageSize;
    data['nextPage'] = this.nextPage;
    data['length'] = this.length;
    data['totalCount'] = this.totalCount;
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
  List<Null>? postComments;
  List<PostLikes>? postLikes;
  List<Null>? postBookmarks;
  PostedBy? postedBy;
  ShareDetails? shareDetails;
  bool? isReported;
  List<Null>? reportId;
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
    loc = json['loc'] != null ? new Loc.fromJson(json['loc']) : null;
    postDescription = json['postDescription'];
    postHashTags = json['postHashTags'];
    if (json['postMedia'] != null) {
      postMedia = <PostMedia>[];
      json['postMedia'].forEach((v) {
        postMedia!.add(new PostMedia.fromJson(v));
      });
    }
    if (json['postLikes'] != null) {
      postLikes = <PostLikes>[];
      json['postLikes'].forEach((v) {
        postLikes!.add(new PostLikes.fromJson(v));
      });
    }
    postedBy = json['postedBy'] != null
        ? new PostedBy.fromJson(json['postedBy'])
        : null;
    shareDetails = json['shareDetails'] != null
        ? new ShareDetails.fromJson(json['shareDetails'])
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['isAdvertorialPost'] = this.isAdvertorialPost;
    data['isBookmarkedByMe'] = this.isBookmarkedByMe;
    data['isLikedByMe'] = this.isLikedByMe;
    data['isSharedPost'] = this.isSharedPost;
    data['address'] = this.address;
    if (this.loc != null) {
      data['loc'] = this.loc!.toJson();
    }
    data['postDescription'] = this.postDescription;
    data['postHashTags'] = this.postHashTags;
    if (this.postMedia != null) {
      data['postMedia'] = this.postMedia!.map((v) => v.toJson()).toList();
    }
    if (this.postLikes != null) {
      data['postLikes'] = this.postLikes!.map((v) => v.toJson()).toList();
    }
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    if (this.shareDetails != null) {
      data['shareDetails'] = this.shareDetails!.toJson();
    }
    data['isReported'] = this.isReported;

    data['fontColor'] = this.fontColor;
    data['backgroundColor'] = this.backgroundColor;
    data['type'] = this.type;
    data['commentAllowed'] = this.commentAllowed;
    data['partnerId'] = this.partnerId;
    data['status'] = this.status;
    data['postAuthor'] = this.postAuthor;
    data['zipCode'] = this.zipCode;
    data['category'] = this.category;
    data['dataPrivacyRule'] = this.dataPrivacyRule;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['mediaType'] = this.mediaType;
    data['url'] = this.url;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['isDefaultImage'] = this.isDefaultImage;
    data['defaultImagePath'] = this.defaultImagePath;
    data['createdAt'] = this.createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['userId'] = this.userId;
    data['isDefaultImage'] = this.isDefaultImage;
    data['defaultImagePath'] = this.defaultImagePath;
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
        ? new SharedBy.fromJson(json['sharedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalPostId'] = this.originalPostId;
    data['sharedOn'] = this.sharedOn;
    if (this.sharedBy != null) {
      data['sharedBy'] = this.sharedBy!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicUrl'] = this.profilePicUrl;
    return data;
  }
}