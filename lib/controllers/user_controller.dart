import 'package:brands_projects/models/user_model.dart';
import 'package:get/get.dart';

class USERModel extends GetxController {
  USER me = USER(username: 'null', email: 'null', password: 'null', uId: 'null',image: 'https://cdn5.vectorstock.com/i/thumb-large/45/79/male-avatar-profile-picture-silhouette-light-vector-4684579.jpg');

  void createMyUser ({
    required String username,
    required String email,
    required String password,
    required String uId,
    profileImage
  }){
    me.username = username;
    me.email = email;
    me.image = profileImage;
    me.uId = uId;
    me.password = password;
  }

  USER getUSER (){
    return me;
  }
}
