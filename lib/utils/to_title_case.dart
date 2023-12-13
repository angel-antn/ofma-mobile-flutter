String toTitleCase(String text) {
  return text.split(' ').map((word) {
    if (word.isNotEmpty) {
      var first = word[0].toUpperCase();
      var rest = word.substring(1).toLowerCase();
      return '$first$rest';
    }
    return '';
  }).join(' ');
}
