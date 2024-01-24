String toTitleCase(String text) {
  return text.split(' ').map((word) {
    if (word.isNotEmpty) {
      String first = word[0].toUpperCase();
      String rest = word.substring(1).toLowerCase();
      return '$first$rest';
    }
    return '';
  }).join(' ');
}
