class EventData {
  final int id;
  final String description;
  final List? interests;
  final List? members;
  final String title;
  final bool locationBased;
  final double? latitude;
  final double? longitude;
  final int hostID;
  final int maxPeople;
  final int minPeople;
  final String startEvent;
  final bool hasStarted;

  const EventData(
      {required this.id,
      required this.description,
      required this.interests,
      required this.members,
      required this.title,
      required this.locationBased,
      required this.latitude,
      required this.longitude,
      required this.hostID,
      required this.maxPeople,
      required this.minPeople,
      required this.startEvent,
      required this.hasStarted});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      description: json['description'],
      interests: json['interests'],
      members: json['members'],
      title: json['title'],
      locationBased: json['locationBased'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      hostID: json['hostID'],
      maxPeople: json['maxPeople'],
      minPeople: json['minPeople'],
      startEvent: json['startEvent'],
      hasStarted: json['hasStarted'],
    );
  }
}
