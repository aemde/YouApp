import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'interest_event.dart';
import 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  final TextEditingController interestTextController = TextEditingController();
  final FocusNode unfocus = FocusNode();
  final List<dynamic> interests = [];

  InterestBloc() : super(InterestInitial(interests: [])) {
    on<AddInterest>(_onAddInterest);
    on<RemoveInterest>(_onRemoveInterest);
  }

  void _onAddInterest(AddInterest event, Emitter<InterestState> emit) {
    interests.add(event.interest);
    interestTextController.clear();
    emit(InterestUpdated(interests.toList()));
  }

  void _onRemoveInterest(RemoveInterest event, Emitter<InterestState> emit) {
    interests.remove(event.interest);
    emit(InterestUpdated(interests.toList()));
  }
}
