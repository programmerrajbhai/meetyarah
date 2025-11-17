class Urls{
  static String _rootUrl="http://192.168.1.107/api";
  static String loginApi= "$_rootUrl/login.php";
  static String registerApi= "$_rootUrl/register.php";
  static String get_all_posts= "$_rootUrl/get_all_posts.php";

  static get getCommentsApi => "$_rootUrl/get_comments.php";

  static String get addCommentApi => "$_rootUrl/add_comment.php";
}