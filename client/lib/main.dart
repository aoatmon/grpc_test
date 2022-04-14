import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:protos/protos.dart';

const _host = 'localhost';
const _port = 50051;

GreeterClient get _client => GreeterClient(
      ClientChannel(
        _host,
        port: _port,
        options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          codecRegistry: CodecRegistry(
            codecs: const [
              GzipCodec(),
              IdentityCodec(),
            ],
          ),
        ),
      ),
    );

void _snackbar(
  BuildContext context, {
  String label = 'ok',
  required String message,
}) =>
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            textColor: Theme.of(context).backgroundColor,
            label: label,
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        ),
      );

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({
    final key = const ValueKey('Home'),
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController()..text = 'world';
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed(BuildContext context) async {
    try {
      final reply = await _client.sayHello(
        HelloRequest()..name = _controller.text,
        options: CallOptions(compression: const GzipCodec()),
      );
      _snackbar(context, message: reply.message);
    } catch (e) {
      _snackbar(context, message: '$e');
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: TextField(controller: _controller),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _onPressed(context),
          child: const Icon(Icons.forward),
        ),
      ),
    );
  }
}
