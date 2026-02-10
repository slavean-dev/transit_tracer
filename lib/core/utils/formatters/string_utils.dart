String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String cityCutter(String input) {
  if (input.isEmpty) return input;
  return input.split(',').first.trim();
}
