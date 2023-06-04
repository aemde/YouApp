abstract class InterestState {}

class InterestInitial extends InterestState {
  final List<dynamic> interests;

  InterestInitial({required this.interests});
}

class InterestUpdated extends InterestState {
  final List<dynamic> interests;

  InterestUpdated(this.interests);
}
