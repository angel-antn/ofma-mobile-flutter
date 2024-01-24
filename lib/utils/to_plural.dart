String toPlural(String text) {
  return text.split(' ').map((word) {
    if (word.isNotEmpty) {
      return '${word}s';
    }
    return '';
  }).join(' ');
}
