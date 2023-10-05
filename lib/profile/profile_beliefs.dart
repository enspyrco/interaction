import 'package:perception/perception.dart';

class ProfileBeliefs implements CoreBeliefs {
  ProfileBeliefs({
    required this.firstName,
    required this.lastName,
    required this.picUrl,
  });

  final String firstName;
  final String lastName;
  final String picUrl;

  static ProfileBeliefs get initial => ProfileBeliefs(
        firstName: '',
        lastName: '',
        picUrl: '',
      );

  @override
  ProfileBeliefs copyWith({
    String? firstName,
    String? picUrl,
    String? lastName,
  }) =>
      ProfileBeliefs(
        firstName: firstName ?? this.firstName,
        picUrl: picUrl ?? this.picUrl,
        lastName: lastName ?? this.lastName,
      );

  @override
  toJson() => {
        'firstName': firstName,
        'navigation': picUrl,
        'lastName': lastName,
      };
}
