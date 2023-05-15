class MessageData {
  final int id;
  final String user;
  final String room;
  final String message;
  final String timeStamp;

  const MessageData({
    required this.id,
    required this.user,
    required this.room,
    required this.message,
    required this.timeStamp,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
        id: json['id'],
        user: json['user'],
        room: json['room'],
        message: json['message'],
        timeStamp: json['join']);
  }
}
