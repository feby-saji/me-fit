import 'package:hive/hive.dart';
part 'user_profile_details.g.dart';

@HiveType(typeId: 1)
class ModelOfUserProfileDetails {
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  String? imagePath;

  ModelOfUserProfileDetails({
    required this.userName,
    required this.email,
    required this.password,
    this.imagePath,
  });
}
