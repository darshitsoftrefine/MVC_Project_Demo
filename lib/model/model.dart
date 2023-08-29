// To parse this JSON data, do
//
//     final coupinoModel = coupinoModelFromJson(jsonString);

import 'dart:convert';

CoupinoModel coupinoModelFromJson(String str) => CoupinoModel.fromJson(json.decode(str));

String coupinoModelToJson(CoupinoModel data) => json.encode(data.toJson());

class CoupinoModel {
  ContactPerson contactPerson;
  Address address;
  BusinessInformation businessInformation;
  TariffDetails tariffDetails;
  List<String> role;
  String status;
  List<dynamic> announcements;
  List<dynamic> locations;
  List<dynamic> coupinos;
  bool needsDefaultCoupino;
  int coupinoLimit;
  bool needsApproval;
  String id;
  String email;
  DateTime creationDate;
  bool isActive;
  bool isEmailVerified;
  bool isRegistrationComplete;
  int v;
  DateTime emailVerifiedDate;
  DateTime loginTimestamp;
  String loginToken;
  List<dynamic> banHistory;
  dynamic markedForDeletion;

  CoupinoModel({
    required this.contactPerson,
    required this.address,
    required this.businessInformation,
    required this.tariffDetails,
    required this.role,
    required this.status,
    required this.announcements,
    required this.locations,
    required this.coupinos,
    required this.needsDefaultCoupino,
    required this.coupinoLimit,
    required this.needsApproval,
    required this.id,
    required this.email,
    required this.creationDate,
    required this.isActive,
    required this.isEmailVerified,
    required this.isRegistrationComplete,
    required this.v,
    required this.emailVerifiedDate,
    required this.loginTimestamp,
    required this.loginToken,
    required this.banHistory,
    this.markedForDeletion,
  });

  factory CoupinoModel.fromJson(Map<String, dynamic> json) => CoupinoModel(
    contactPerson: ContactPerson.fromJson(json["contactPerson"]),
    address: Address.fromJson(json["address"]),
    businessInformation: BusinessInformation.fromJson(json["businessInformation"]),
    tariffDetails: TariffDetails.fromJson(json["tariffDetails"]),
    role: List<String>.from(json["role"].map((x) => x)),
    status: json["status"],
    announcements: List<dynamic>.from(json["announcements"].map((x) => x)),
    locations: List<dynamic>.from(json["locations"].map((x) => x)),
    coupinos: List<dynamic>.from(json["coupinos"].map((x) => x)),
    needsDefaultCoupino: json["needsDefaultCoupino"],
    coupinoLimit: json["coupinoLimit"],
    needsApproval: json["needsApproval"],
    id: json["_id"],
    email: json["email"],
    creationDate: DateTime.parse(json["creationDate"]),
    isActive: json["isActive"],
    isEmailVerified: json["isEmailVerified"],
    isRegistrationComplete: json["isRegistrationComplete"],
    v: json["__v"],
    emailVerifiedDate: DateTime.parse(json["emailVerifiedDate"]),
    loginTimestamp: DateTime.parse(json["loginTimestamp"]),
    loginToken: json["loginToken"],
    banHistory: List<dynamic>.from(json["banHistory"].map((x) => x)),
    markedForDeletion: json["markedForDeletion"],
  );

  Map<String, dynamic> toJson() => {
    "contactPerson": contactPerson.toJson(),
    "address": address.toJson(),
    "businessInformation": businessInformation.toJson(),
    "tariffDetails": tariffDetails.toJson(),
    "role": List<dynamic>.from(role.map((x) => x)),
    "status": status,
    "announcements": List<dynamic>.from(announcements.map((x) => x)),
    "locations": List<dynamic>.from(locations.map((x) => x)),
    "coupinos": List<dynamic>.from(coupinos.map((x) => x)),
    "needsDefaultCoupino": needsDefaultCoupino,
    "coupinoLimit": coupinoLimit,
    "needsApproval": needsApproval,
    "_id": id,
    "email": email,
    "creationDate": creationDate.toIso8601String(),
    "isActive": isActive,
    "isEmailVerified": isEmailVerified,
    "isRegistrationComplete": isRegistrationComplete,
    "__v": v,
    "emailVerifiedDate": emailVerifiedDate.toIso8601String(),
    "loginTimestamp": loginTimestamp.toIso8601String(),
    "loginToken": loginToken,
    "banHistory": List<dynamic>.from(banHistory.map((x) => x)),
    "markedForDeletion": markedForDeletion,
  };
}

class Address {
  String street;
  String streetNumber;
  String postalCode;
  String city;
  String country;
  String addressValidationCode;
  bool isAddressValidated;
  DateTime resendValidationCodeRestrictionUpto;
  bool isAddressCodeResent;
  int wrongAttemptCount;
  DateTime lastUpdatedOn;

  Address({
    required this.street,
    required this.streetNumber,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.addressValidationCode,
    required this.isAddressValidated,
    required this.resendValidationCodeRestrictionUpto,
    required this.isAddressCodeResent,
    required this.wrongAttemptCount,

    required this.lastUpdatedOn,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    streetNumber: json["streetNumber"],
    postalCode: json["postalCode"],
    city: json["city"],
    country: json["country"],
    addressValidationCode: json["addressValidationCode"],
    isAddressValidated: json["isAddressValidated"],
    resendValidationCodeRestrictionUpto: DateTime.parse(json["resendValidationCodeRestrictionUpto"]),
    isAddressCodeResent: json["isAddressCodeResent"],
    wrongAttemptCount: json["wrongAttemptCount"],

    lastUpdatedOn: DateTime.parse(json["lastUpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "streetNumber": streetNumber,
    "postalCode": postalCode,
    "city": city,
    "country": country,
    "addressValidationCode": addressValidationCode,
    "isAddressValidated": isAddressValidated,
    "resendValidationCodeRestrictionUpto": resendValidationCodeRestrictionUpto.toIso8601String(),
    "isAddressCodeResent": isAddressCodeResent,
    "wrongAttemptCount": wrongAttemptCount,
    "lastUpdatedOn": lastUpdatedOn.toIso8601String(),
  };
}

class BusinessInformation {
  String name;
  dynamic uStId;
  String registrationNumber;

  BusinessInformation({
    required this.name,
    this.uStId,
    required this.registrationNumber,
  });

  factory BusinessInformation.fromJson(Map<String, dynamic> json) => BusinessInformation(
    name: json["name"],
    uStId: json["UStID"],
    registrationNumber: json["registrationNumber"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "UStID": uStId,
    "registrationNumber": registrationNumber,
  };
}

class ContactPerson {
  String defaultImagePath;
  bool isDefaultImage;
  String title;
  String academicTitle;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  DateTime dob;
  String gender;
  String profilePic;

  ContactPerson({
    required this.defaultImagePath,
    required this.isDefaultImage,
    required this.title,
    required this.academicTitle,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.profilePic,
  });

  factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
    defaultImagePath: json["defaultImagePath"],
    isDefaultImage: json["isDefaultImage"],
    title: json["title"],
    academicTitle: json["academicTitle"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "defaultImagePath": defaultImagePath,
    "isDefaultImage": isDefaultImage,
    "title": title,
    "academicTitle": academicTitle,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "dob": dob.toIso8601String(),
    "gender": gender,
    "profilePic": profilePic,
  };
}

class TariffDetails {
  DateTime startDate;
  int duration;
  int maxCoupinoCount;
  int maxLocationCount;

  TariffDetails({
    required this.startDate,
    required this.duration,
    required this.maxCoupinoCount,
    required this.maxLocationCount,
  });

  factory TariffDetails.fromJson(Map<String, dynamic> json) => TariffDetails(
    startDate: DateTime.parse(json["startDate"]),
    duration: json["duration"],
    maxCoupinoCount: json["maxCoupinoCount"],
    maxLocationCount: json["maxLocationCount"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate.toIso8601String(),
    "duration": duration,
    "maxCoupinoCount": maxCoupinoCount,
    "maxLocationCount": maxLocationCount,
  };
}