import 'package:brands_projects/models/user_model.dart';
import 'package:get/get.dart';

class USERModel extends GetxController {
  Rx<USER> me = USER(username: 'null', email: 'null', password: 'null', uId: 'null',image: 'https://cdn5.vectorstock.com/i/thumb-large/45/79/male-avatar-profile-picture-silhouette-light-vector-4684579.jpg').obs;

  void createMyUser ({
    required String username,
    required String email,
    required String password,
    required String uId,
    profileImage
  }){
    me.value.username = username;
    me.value.email = email;
    me.value.image = profileImage;
    me.value.uId = uId;
    me.value.password = password;
  }

  USER getUSER (){
    return me.value;
  }
}
