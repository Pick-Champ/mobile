import 'package:pick_champ/core/const/app_env.dart';

enum EndPointEnums {
  login('/api/auth/login'),
  register('/api/auth/register'),
  loginSocial('/api/auth/loginSocial'),
  registerSocial('/api/auth/registerSocial'),
  forgotPw('/api/auth/forgotPw'),

  addComment('/api/comment/add'),
  deleteComment('/api/comment/delete'),
  getComment('/api/comment/get'),
  likeComment('/api/comment/like'),

  getByCategory('/api/quiz/getByCategory'),
  toggleEditorSelect('/api/quiz/toggleEditorSelect'),
  getByUser('/api/quiz/getByUser'),
  getById('/api/quiz/getById'),
  home('/api/quiz/home'),
  createQuiz('/api/quiz/create'),
  deleteQuiz('/api/quiz/delete'),
  complete('/api/quiz/complete'),

  react('/api/reaction/react'),
  getReaction('/api/reaction/get'),

  report('/api/report/report'),
  getReports('/api/report/getReports'),

  getUser('/api/user/get'),
  updateUser('/api/user/update'),
  changePw('/api/user/changePw'),
  removeUser('/api/user/remove'),
  photoUser('/api/user/photo'),
  scoreboard('/api/user/scoreboard');

  const EndPointEnums(this.value);

  final String value;

  String get fullUrl {
    final baseUrl = AppEnv.baseUrl;
    return '$baseUrl$value';
  }
}
