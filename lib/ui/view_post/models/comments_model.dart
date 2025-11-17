class CommentModel {
  final int commentId;
  final String commentText;
  final String createdAt;
  final int userId;
  final String username;
  final String like_count;
  final String comment_count;
  final String fullName;
  final String? profilePictureUrl; // Eti null hote pare

  CommentModel( {
    required this.like_count,
    required this.comment_count,
    required this.commentId,
    required this.commentText,
    required this.createdAt,
    required this.userId,
    required this.username,
    required this.fullName,
    this.profilePictureUrl,

  });

  // API theke asa JSON map-ke CommentModel object-e porinoto korbe
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: int.parse(json['comment_id'].toString()),
      commentText: json['comment_text'],
      createdAt: json['created_at'],
      userId: int.parse(json['user_id'].toString()),
      username: json['username'],
      fullName: json['full_name'],
      profilePictureUrl: json['profile_picture_url'],

      like_count: json['like_count'],
      comment_count: json['comment_count'],
    );
  }
}