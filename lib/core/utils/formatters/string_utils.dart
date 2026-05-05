extension StringX on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String cityCutter() {
    if (isEmpty) return this;
    return split(',').first.trim();
  }
}
