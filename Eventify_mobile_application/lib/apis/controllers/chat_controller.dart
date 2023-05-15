import 'package:signalr_netcore/signalr_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../chat/chat_message.dart';

const serverUrl = "http://office.pepr.com:25253/chat";

final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

//final hubConnection.onClose( (error) => print('Connection closed'));
Future connectService() async {
  await hubConnection.start();
  return hubConnection;
}

Future disconnectService() async {
  await hubConnection.stop();
}

Future getService() async {
  return hubConnection;
}

Future joinRoom(String room, String user) async {
  await hubConnection
      .invoke('SendMessage', args: [user, "", room, true, false]);
}

Future sendMessage(String user, String message, String room) async {
  await hubConnection
      .invoke('SendMessage', args: [user, message, room, false, false]);
}

Future leaveRoom(String room, String user) async {
  await hubConnection
      .invoke('SendMessage', args: [user, "", room, false, true]);
}

Future<List<ChatMessage>> getMessageHistory(String room) async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25253/ChatHistory/Get/$room'));
  List responseList = json.decode(response.body) as List<dynamic>;

  List<ChatMessage> messages = [];
  for (int i = 0; i < responseList.length; i++) {
    messages.add(ChatMessage.fromJson(responseList[i]));
  }

  return messages;
}
