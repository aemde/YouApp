abstract class InterestEvent {}

class AddInterest extends InterestEvent {
  final String interest;

  AddInterest(this.interest);
}

class RemoveInterest extends InterestEvent {
  final String interest;

  RemoveInterest(this.interest);
}
