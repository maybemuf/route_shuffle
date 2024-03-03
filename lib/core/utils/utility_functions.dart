double valueToPercentage(double value, double minimum, double maximum) {
  return ((value - minimum) / maximum) * 100;
}

double percentageToValue(double percentage, double minimum, double maximum) {
  return minimum + (percentage / 100) * (maximum - minimum);
}
