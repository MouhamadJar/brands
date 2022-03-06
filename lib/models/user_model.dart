class USER {
  late String username;
  late String email;
  late String password;
  late String uId;
  late String image;

  USER({
    required this.username,
    required this.email,
    required this.password,
    required this.uId,
    image = 'https://cdn5.vectorstock.com/i/thumb-large/45/79/male-avatar-profile-picture-silhouette-light-vector-4684579.jpg',
  });

  USER.fromJson({
    required Map<String, dynamic> json,
  }) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'uId': uId,
      'image': image,
    };
  }
}
