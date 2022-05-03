extension RemoveAllListExtension<T> on List<T> {
  void removeAll(Iterable<T> elements) => elements.forEach(remove);
}
