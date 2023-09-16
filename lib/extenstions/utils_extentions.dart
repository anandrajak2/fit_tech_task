extension getdate on String {
  calculateDaysSinceGivenDate() {
    DateTime givenDate = DateTime.parse(this);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(givenDate);
    return difference.inDays.toString();
  }
}
