class CustomerInteration {
  final int newVisits;
  final int priceChecks;
  final int unanswered;
  final int newReviews;

  CustomerInteration({
    required this.newVisits,
    required this.priceChecks,
    required this.unanswered,
    required this.newReviews,
  });
}

final CustomerInteration interation = CustomerInteration(
  newVisits: 32,
  priceChecks: 25,
  unanswered: 5,
  newReviews: 9,
);
