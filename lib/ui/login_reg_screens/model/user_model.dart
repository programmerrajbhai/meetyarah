class UserModel {
  late final String? user_id;
  late final String username;
  late final String email;
  late final String full_name;
  late final String profile_picture_url;


  //Named constructor
    UserModel.fromJson (Map<String, dynamic> json) {
      user_id = json['user_id'];
      username = json['username'];
      email = json['email'];
      full_name = json['full_name'];
      profile_picture_url = json['profile_picture_url'];
    }


    Map<String, dynamic> toJson(){
      return {
        'user_id':user_id,
        'username':username,
        'email':email,
        'full_name':full_name,
        'profile_picture_url':profile_picture_url,
      };
    }





}

//
// {
// "status": "success",
// "message": "Login successful.",
// "user": {
// "user_id": 15,
// "username": "xxxx",
// "email": "xxxx",
// "full_name": "xxxx",
// "profile_picture_url": null
// },
// "token": "833a99ac5bb82233fc654dc1be11b41f2b2ea699df1d9e2b9f77b70169c1c926"
// }
