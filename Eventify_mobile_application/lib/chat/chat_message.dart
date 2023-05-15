class ChatMessage {
  late int id;
  late String message;
  late String user;
  late String chatRoom;
  late String timestamp;

  ChatMessage(this.id, this.message, this.user, this.chatRoom, this.timestamp);

  ChatMessage.short(this.user, this.message);

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final message = json['message'];
    final user = json['user'];
    final chatRoom = json['chatRoom'];
    final timestamp = json['timestamp'];
    return ChatMessage(id, message, user, chatRoom, timestamp);
  }
}
