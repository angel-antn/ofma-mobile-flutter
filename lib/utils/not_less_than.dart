notLessThan({required int lessThan, required int number}) {
  if (number < lessThan) {
    return lessThan;
  }
  return number;
}
