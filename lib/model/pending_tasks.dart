class PendingTasks {
  final int noOfDeliveryDelayed;
  final int noOfPickupDelayed;
  final int noOfDeliveryPending;
  final int noOfDeliveryScheduled;
  final int noOfPickupPending;
  final int noOfPickupScheduled;

  PendingTasks({
    required this.noOfDeliveryDelayed,
    required this.noOfPickupDelayed,
    required this.noOfDeliveryPending,
    required this.noOfDeliveryScheduled,
    required this.noOfPickupPending,
    required this.noOfPickupScheduled,
  });
}

final PendingTasks tasks = 
  PendingTasks(
      noOfDeliveryDelayed: 2,
      noOfPickupDelayed: 1,
      noOfDeliveryPending: 5,
      noOfDeliveryScheduled: 7,
      noOfPickupPending: 3,
      noOfPickupScheduled: 4
  );

