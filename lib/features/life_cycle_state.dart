import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LifeCycleState extends StatefulWidget {
  final Widget child;

  const LifeCycleState({Key? key, required this.child}) : super(key: key);

  @override
  State<LifeCycleState> createState() => _LifeCycleStateState();
}

class _LifeCycleStateState extends State<LifeCycleState>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      print("online");
      sendStatusToServer('online');
    } else {
      print("offline");
      sendStatusToServer('offline');
    }
  }

  void sendStatusToServer(String status) async {
    const deviceId = 'my_device_id';
    final response = await http.post(
      Uri.parse('http://your-server.com/api/status'),
      body: {
        'deviceId': deviceId,
        'status': status,
      },
    );

    if (response.statusCode != 200) {
      print('Failed to send status to server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
