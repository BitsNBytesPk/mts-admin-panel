
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/api_base_helper.dart';

class WebSocket {

  final channel = WebSocketChannel.connect(
    Uri.parse("ws://localhost:8080"),
  );

  WebSocket() {
    channel.stream.listen((event) {
      final data = jsonDecode(event);
      if(data['event'] == 'socket:connection_established') {
        subscribeToChannel(jsonDecode(data['data'])['socket_id']);
      }
    });
  }

  void subscribeToChannel(String socketId) {
    ApiBaseHelper.postMethod(
        url: '/broadcasting/auth',
        body: {
      'socket_id': socketId,
      'channel_name': 'private-yabor.order.created.efa209b9-b0fa-49f2-b50d-10679ac9089b',
    }).then((value) {
      if(value.success!) {
        channel.sink.add(jsonEncode({
          'event': 'socket:subscribe',
          'data': {
            'channel': 'private-yabor.order.created.efa209b9-b0fa-49f2-b50d-10679ac9089b',
            'auth': value.data
          }
        }));
      }
    });
  }
}