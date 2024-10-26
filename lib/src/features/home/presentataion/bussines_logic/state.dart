abstract class CheckInCheckOutState {}

// Initial state when no action has been taken
class InitialState extends CheckInCheckOutState {}

// State when the request is in progress
class LoadingState extends CheckInCheckOutState {}

// States for Check-In
class CheckInSuccessState extends CheckInCheckOutState {}

class CheckInFailureState extends CheckInCheckOutState {
  final String error;

  CheckInFailureState(this.error);
}

// States for Check-Out
class CheckOutSuccessState extends CheckInCheckOutState {}

class CheckOutFailureState extends CheckInCheckOutState {
  final String error;

  CheckOutFailureState(this.error);
}

// States for Enabling Notification
class EnableNotificationSuccessState extends CheckInCheckOutState {}

class EnableNotificationFailureState extends CheckInCheckOutState {
  final String error;

  EnableNotificationFailureState(this.error);
}
