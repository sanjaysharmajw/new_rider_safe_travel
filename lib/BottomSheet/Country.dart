class Country {

  const Country({
    required this.name,
    required this.address,
  });

  final String name;
  final String address;

  @override
  String toString() {
    return '$name ($address)';
  }
}