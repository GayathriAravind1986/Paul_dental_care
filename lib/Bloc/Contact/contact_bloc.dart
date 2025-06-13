import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/Api/apiProvider.dart';

abstract class ContactDentalEvent {}

class AwarenessDental extends ContactDentalEvent {}

class ReviewDental extends ContactDentalEvent {
  String? name;
  String? review;
  String? rating;
  ReviewDental(
      this.name,
      this.review,
      this.rating
      );
}

class ContactDental extends ContactDentalEvent {}

class EventDental extends ContactDentalEvent {}

class HomeDental extends ContactDentalEvent {}

class ContactDentalBloc extends Bloc<ContactDentalEvent, dynamic> {
  ContactDentalBloc() : super(dynamic) {
    on<ContactDental>((event, emit) async {
      await ApiProvider().getContactAPI().then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });
    on<ReviewDental>((event, emit) async {
      await ApiProvider().postReviewAPI(event.name,event.review,event.rating).then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });
    on<EventDental>((event, emit) async {
      await ApiProvider().getEventAPI().then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });

    on<AwarenessDental>((event, emit) async {
      await ApiProvider().getAwarenessAPI().then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });
    on<HomeDental>((event, emit) async {
      await ApiProvider().getHomeAPI().then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });

  }
}

