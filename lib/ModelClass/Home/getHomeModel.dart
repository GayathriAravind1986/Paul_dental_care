import 'package:simple/Bloc/Response/errorResponse.dart';
/// success : true
/// data : {"status":true,"slideshow":[{"image":"https://pauldentalcare.com/lara/front-ends/home/17442779151000318101.jpg","title":"Healthy Smiles for Life","subtitle":"Expert care with advanced technology."},{"image":"https://pauldentalcare.com/lara/front-ends/home/1742815999shutterstock_1914474613.jpg","title":"Advanced Dental","subtitle":"Your smile, our priority."},{"image":"https://pauldentalcare.com/lara/front-ends/home/1744095519treatment.jpeg","title":"Caring for Every Smile","subtitle":"Quality service for all ages."}],"appointment_count":"25","client_count":"600","team_description":"\"Our dedicated team of experienced dentists and caring staff is committed to providing top-quality dental care with a personal touch. From routine check-ups to advanced treatments, we ensure a comfortable and stress-free experience for every patient.\"","team_members":[{"name":"Dr Paul Raj","post":"BDS - Implantologist","image":"https://pauldentalcare.com/lara/front-ends/about/1749465191IMG_20250609_160246.jpg"},{"name":"Dr Bala Krishnan","post":"MDS - Oral Maxilo Facial Surgery","image":"https://pauldentalcare.com/lara/front-ends/about/1749375304IMG-20250608-WA0027.jpg"},{"name":"Dr Jenarthan","post":"MDS - Paedodontist","image":"https://pauldentalcare.com/lara/front-ends/about/1749477316IMG_20250609_192425.jpg"}],"reviews":[{"id":13,"name":"Selvam","rating":5,"review":"Best dental clinic","status":1,"created_at":"2025-05-02T05:22:52.000000Z","updated_at":"2025-05-02T05:22:52.000000Z"},{"id":11,"name":"இராஜகுமார்","rating":5,"review":"Doctor interaction and quality of care are good","status":1,"created_at":"2025-04-22T08:02:30.000000Z","updated_at":"2025-04-22T08:02:30.000000Z"},{"id":10,"name":"Karate rahul","rating":5,"review":"I got good treatment in this Dental and dentist 🦷😃","status":1,"created_at":"2025-04-22T06:41:33.000000Z","updated_at":"2025-04-22T06:41:33.000000Z"},{"id":4,"name":"Virat","rating":5,"review":"Good......","status":1,"created_at":"2025-03-24T07:29:44.000000Z","updated_at":"2025-03-24T07:29:44.000000Z"},{"id":3,"name":"Sofiya","rating":5,"review":"Good","status":1,"created_at":"2025-03-15T10:58:22.000000Z","updated_at":"2025-03-15T10:58:22.000000Z"},{"id":2,"name":"SentinixTechSolutions","rating":5,"review":"Good Services","status":1,"created_at":"2025-03-15T09:28:37.000000Z","updated_at":"2025-03-15T09:28:37.000000Z"},{"id":1,"name":"Saranya","rating":5,"review":"Good services","status":1,"created_at":"2025-03-10T11:01:23.000000Z","updated_at":"2025-03-10T11:01:23.000000Z"}]}
/// message : "Home List"

class GetHomeModel {
  GetHomeModel({
      bool? success, 
      Data? data, 
      String? message,
      ErrorResponse? errorResponse,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  GetHomeModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
    if (json['errors'] != null && json['errors'] is Map<String, dynamic>) {
      errorResponse = ErrorResponse.fromJson(json['errors']);
    } else {
      errorResponse = null;
    }
  }
  bool? _success;
  Data? _data;
  String? _message;
  ErrorResponse? errorResponse;
GetHomeModel copyWith({  bool? success,
  Data? data,
  String? message,
}) => GetHomeModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// status : true
/// slideshow : [{"image":"https://pauldentalcare.com/lara/front-ends/home/17442779151000318101.jpg","title":"Healthy Smiles for Life","subtitle":"Expert care with advanced technology."},{"image":"https://pauldentalcare.com/lara/front-ends/home/1742815999shutterstock_1914474613.jpg","title":"Advanced Dental","subtitle":"Your smile, our priority."},{"image":"https://pauldentalcare.com/lara/front-ends/home/1744095519treatment.jpeg","title":"Caring for Every Smile","subtitle":"Quality service for all ages."}]
/// appointment_count : "25"
/// client_count : "600"
/// team_description : "\"Our dedicated team of experienced dentists and caring staff is committed to providing top-quality dental care with a personal touch. From routine check-ups to advanced treatments, we ensure a comfortable and stress-free experience for every patient.\""
/// team_members : [{"name":"Dr Paul Raj","post":"BDS - Implantologist","image":"https://pauldentalcare.com/lara/front-ends/about/1749465191IMG_20250609_160246.jpg"},{"name":"Dr Bala Krishnan","post":"MDS - Oral Maxilo Facial Surgery","image":"https://pauldentalcare.com/lara/front-ends/about/1749375304IMG-20250608-WA0027.jpg"},{"name":"Dr Jenarthan","post":"MDS - Paedodontist","image":"https://pauldentalcare.com/lara/front-ends/about/1749477316IMG_20250609_192425.jpg"}]
/// reviews : [{"id":13,"name":"Selvam","rating":5,"review":"Best dental clinic","status":1,"created_at":"2025-05-02T05:22:52.000000Z","updated_at":"2025-05-02T05:22:52.000000Z"},{"id":11,"name":"இராஜகுமார்","rating":5,"review":"Doctor interaction and quality of care are good","status":1,"created_at":"2025-04-22T08:02:30.000000Z","updated_at":"2025-04-22T08:02:30.000000Z"},{"id":10,"name":"Karate rahul","rating":5,"review":"I got good treatment in this Dental and dentist 🦷😃","status":1,"created_at":"2025-04-22T06:41:33.000000Z","updated_at":"2025-04-22T06:41:33.000000Z"},{"id":4,"name":"Virat","rating":5,"review":"Good......","status":1,"created_at":"2025-03-24T07:29:44.000000Z","updated_at":"2025-03-24T07:29:44.000000Z"},{"id":3,"name":"Sofiya","rating":5,"review":"Good","status":1,"created_at":"2025-03-15T10:58:22.000000Z","updated_at":"2025-03-15T10:58:22.000000Z"},{"id":2,"name":"SentinixTechSolutions","rating":5,"review":"Good Services","status":1,"created_at":"2025-03-15T09:28:37.000000Z","updated_at":"2025-03-15T09:28:37.000000Z"},{"id":1,"name":"Saranya","rating":5,"review":"Good services","status":1,"created_at":"2025-03-10T11:01:23.000000Z","updated_at":"2025-03-10T11:01:23.000000Z"}]

class Data {
  Data({
      bool? status, 
      List<Slideshow>? slideshow, 
      String? appointmentCount, 
      String? clientCount, 
      String? teamDescription, 
      List<TeamMembers>? teamMembers, 
      List<Reviews>? reviews,}){
    _status = status;
    _slideshow = slideshow;
    _appointmentCount = appointmentCount;
    _clientCount = clientCount;
    _teamDescription = teamDescription;
    _teamMembers = teamMembers;
    _reviews = reviews;
}

  Data.fromJson(dynamic json) {
    _status = json['status'];
    if (json['slideshow'] != null) {
      _slideshow = [];
      json['slideshow'].forEach((v) {
        _slideshow?.add(Slideshow.fromJson(v));
      });
    }
    _appointmentCount = json['appointment_count'];
    _clientCount = json['client_count'];
    _teamDescription = json['team_description'];
    if (json['team_members'] != null) {
      _teamMembers = [];
      json['team_members'].forEach((v) {
        _teamMembers?.add(TeamMembers.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Slideshow>? _slideshow;
  String? _appointmentCount;
  String? _clientCount;
  String? _teamDescription;
  List<TeamMembers>? _teamMembers;
  List<Reviews>? _reviews;
Data copyWith({  bool? status,
  List<Slideshow>? slideshow,
  String? appointmentCount,
  String? clientCount,
  String? teamDescription,
  List<TeamMembers>? teamMembers,
  List<Reviews>? reviews,
}) => Data(  status: status ?? _status,
  slideshow: slideshow ?? _slideshow,
  appointmentCount: appointmentCount ?? _appointmentCount,
  clientCount: clientCount ?? _clientCount,
  teamDescription: teamDescription ?? _teamDescription,
  teamMembers: teamMembers ?? _teamMembers,
  reviews: reviews ?? _reviews,
);
  bool? get status => _status;
  List<Slideshow>? get slideshow => _slideshow;
  String? get appointmentCount => _appointmentCount;
  String? get clientCount => _clientCount;
  String? get teamDescription => _teamDescription;
  List<TeamMembers>? get teamMembers => _teamMembers;
  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_slideshow != null) {
      map['slideshow'] = _slideshow?.map((v) => v.toJson()).toList();
    }
    map['appointment_count'] = _appointmentCount;
    map['client_count'] = _clientCount;
    map['team_description'] = _teamDescription;
    if (_teamMembers != null) {
      map['team_members'] = _teamMembers?.map((v) => v.toJson()).toList();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 13
/// name : "Selvam"
/// rating : 5
/// review : "Best dental clinic"
/// status : 1
/// created_at : "2025-05-02T05:22:52.000000Z"
/// updated_at : "2025-05-02T05:22:52.000000Z"

class Reviews {
  Reviews({
      num? id, 
      String? name, 
      num? rating, 
      String? review, 
      num? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _rating = rating;
    _review = review;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Reviews.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _rating = json['rating'];
    _review = json['review'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  num? _rating;
  String? _review;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
Reviews copyWith({  num? id,
  String? name,
  num? rating,
  String? review,
  num? status,
  String? createdAt,
  String? updatedAt,
}) => Reviews(  id: id ?? _id,
  name: name ?? _name,
  rating: rating ?? _rating,
  review: review ?? _review,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  num? get rating => _rating;
  String? get review => _review;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['rating'] = _rating;
    map['review'] = _review;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// name : "Dr Paul Raj"
/// post : "BDS - Implantologist"
/// image : "https://pauldentalcare.com/lara/front-ends/about/1749465191IMG_20250609_160246.jpg"

class TeamMembers {
  TeamMembers({
      String? name, 
      String? post, 
      String? image,}){
    _name = name;
    _post = post;
    _image = image;
}

  TeamMembers.fromJson(dynamic json) {
    _name = json['name'];
    _post = json['post'];
    _image = json['image'];
  }
  String? _name;
  String? _post;
  String? _image;
TeamMembers copyWith({  String? name,
  String? post,
  String? image,
}) => TeamMembers(  name: name ?? _name,
  post: post ?? _post,
  image: image ?? _image,
);
  String? get name => _name;
  String? get post => _post;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['post'] = _post;
    map['image'] = _image;
    return map;
  }

}

/// image : "https://pauldentalcare.com/lara/front-ends/home/17442779151000318101.jpg"
/// title : "Healthy Smiles for Life"
/// subtitle : "Expert care with advanced technology."

class Slideshow {
  Slideshow({
      String? image, 
      String? title, 
      String? subtitle,}){
    _image = image;
    _title = title;
    _subtitle = subtitle;
}

  Slideshow.fromJson(dynamic json) {
    _image = json['image'];
    _title = json['title'];
    _subtitle = json['subtitle'];
  }
  String? _image;
  String? _title;
  String? _subtitle;
Slideshow copyWith({  String? image,
  String? title,
  String? subtitle,
}) => Slideshow(  image: image ?? _image,
  title: title ?? _title,
  subtitle: subtitle ?? _subtitle,
);
  String? get image => _image;
  String? get title => _title;
  String? get subtitle => _subtitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    return map;
  }

}