part of 'profil_bloc.dart';

class ProfilState extends Equatable {
  final String name;
  final String gender;
  final String zodiac;
  final String status;
  final String status1;
  final int loop;
  final String horoscope;
  final String weight;
  final String height;
  final int age;

  final String savedValue;
  final List<String> save;
  final XFile? imageX;

  const ProfilState({
    required this.name,
    required this.gender,
    required this.zodiac,
    required this.status,
    required this.status1,
    required this.loop,
    required this.horoscope,
    required this.weight,
    required this.height,
    required this.age,
    required this.savedValue,
    required this.save,
    required this.imageX,
  });

  factory ProfilState.initial() {
    return const ProfilState(
      name: "",
      gender: "",
      status: "",
      status1: "",
      zodiac: '',
      horoscope: '',
      height: '',
      weight: '',
      age: 0,
      loop: 0,
      savedValue: "",
      save: [],
      imageX: null,
    );
  }

  ProfilState copyWith({
    String? status,
    String? status1,
    int? loop,
    String? name,
    String? gender,
    String? zodiac,
    String? horoscope,
    String? weight,
    String? height,
    int? age,
    String? savedValue,
    List<String>? save,
    XFile? imageX,
  }) {
    return ProfilState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      status1: status1 ?? this.status1,
      loop: loop ?? this.loop,
      zodiac: zodiac ?? this.zodiac,
      horoscope: horoscope ?? this.horoscope,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      savedValue: savedValue ?? this.savedValue,
      save: save ?? this.save,
      imageX: imageX ?? imageX,
    );
  }

  @override
  List<Object> get props => [
        name,
        gender,
        status,
        status1,
        zodiac,
        horoscope,
        height,
        weight,
        loop,
        age,
        savedValue,
        save,
      ];
}
