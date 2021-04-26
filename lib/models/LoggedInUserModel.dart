import 'package:hive/hive.dart';

part 'LoggedInUserModel.g.dart';

@HiveType(typeId: 1)
class LoggedInUser extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String publicKey;

  @HiveField(2)
  String profilePic;

  @HiveField(3)
  bool isLoggedIn;

  LoggedInUser({
    required this.username,
    required this.publicKey,
    required this.profilePic,
    required this.isLoggedIn,
  });

  List<dynamic> get props => [
        username,
        publicKey,
        profilePic,
        isLoggedIn,
      ];

  factory LoggedInUser.fromMap(Map<String, dynamic> map) {
    return LoggedInUser(
      username: map['Username'] ?? '',
      publicKey: map['PublicKey'] ?? '',
      profilePic: map['ProfilePic'] ?? '',
      isLoggedIn: map['IsLoggedIn'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Username": this.username,
        "PublicKey": this.publicKey,
        "ProfilePic": this.profilePic,
        "IsloggedIn": this.isLoggedIn,
      };
}
