import 'package:simple/Bloc/Response/errorResponse.dart';
/// status : true
/// message : "Thanks for your review!"

class PostReviewModel {
  PostReviewModel({
      bool? status, 
      String? message,
      ErrorResponse? errorResponse,
  }){
    _status = status;
    _message = message;

}

  PostReviewModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  ErrorResponse? errorResponse;
PostReviewModel copyWith({  bool? status,
  String? message,
}) => PostReviewModel(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}