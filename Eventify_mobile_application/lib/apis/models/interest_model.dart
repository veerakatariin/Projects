class InterestData {
  final int id;
  final String name;
  final String description;

  const InterestData({
    required this.id,
    required this.name,
    required this.description,
  });

  factory InterestData.fromJson(Map<String, dynamic> json) {
    return InterestData(
        id: json['id'], name: json['name'], description: json['description']);
  }
}
