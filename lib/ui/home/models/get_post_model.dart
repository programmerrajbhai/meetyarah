class GetPostModel {
  String? post_id;
  String? post_content;
  String? image_url;
  String? created_at;
  String? user_id;
  String? username;
  String? full_name;
  String? profile_picture_url;
  int? like_count;
  int? comment_count;

  GetPostModel({
    this.post_id,
    this.post_content,
    this.image_url,
    this.created_at,
    this.user_id,
    this.username,
    this.full_name,
    this.profile_picture_url,
    this.like_count,
    this.comment_count,
  });

  factory GetPostModel.fromJson(Map<String, dynamic> json) {
    return GetPostModel(
      post_id: json['post_id'],
      post_content: json['post_content'],
      image_url: json['image_url'],
      created_at: json['created_at'],
      user_id: json['user_id'],
      username: json['username'],
      full_name: json['full_name'],
      profile_picture_url: json['profile_picture_url'],
      like_count: json['like_count'],
      comment_count: json['comment_count'],
    );
  }
}
