import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfileBloc extends Bloc<ProfilEvent, ProfilState> {
  XFile? imageX;

  ProfileBloc() : super(ProfilState.initial()) {
    on<UpdateTapProfile>(_onUpdateTapProfile);
    on<UpdateTapAbout1>(_onUpdateTapAbout1);
    on<UpdateTapAbout2>(_onUpdateTapAbout2);
    on<UpdateTapAbout3>(_onUpdateTapAbout3);
    on<UpdateLooping>(_onLoopingEvent);
  }

  void _onUpdateTapProfile(UpdateTapProfile event, Emitter<ProfilState> emit) {
    emit(state.copyWith(status1: "LOADED"));
  }

  void _onUpdateTapAbout1(UpdateTapAbout1 event, Emitter<ProfilState> emit) {
    emit(state.copyWith(status: "LOADED"));
  }

  void _onUpdateTapAbout2(UpdateTapAbout2 event, Emitter<ProfilState> emit) {
    emit(state.copyWith(
      name: event.name,
      status: "SAVED",
      horoscope: event.horoscope,
      zodiac: event.zodiac,
      weight: event.weight,
      height: event.height,
      gender: event.gender,
    ));
  }

  void _onUpdateTapAbout3(UpdateTapAbout3 event, Emitter<ProfilState> emit) {
    emit(state.copyWith(
      horoscope: event.horoscope,
      zodiac: event.zodiac,
      age: event.age,
      gender: event.gender,
    ));
  }

  void _onLoopingEvent(UpdateLooping event, Emitter<ProfilState> emit) {
    emit(state.copyWith(loop: event.loop));
  }
}
