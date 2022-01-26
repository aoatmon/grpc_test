import 'package:client/protos/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grpc/grpc.dart';

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

Future<String?> Function() _onPressed(BuildContext context, String name) =>
    () async {
      try {
        final reply = await _client.sayHello(
          HelloRequest()..name = name,
          options: CallOptions(compression: const GzipCodec()),
        );
        _snackbar(context, message: reply.message);
      } catch (e) {
        _snackbar(context, message: '$e');
      }
    };
void main() => runApp(const Application());

class Application extends HookWidget {
  const Application({
    final key = const ValueKey('Application'),
  }) : super(key: key);

  @override
  Widget build(context) {
    final controller = useTextEditingController()..text = 'world';
    return MaterialApp(
      home: Scaffold(
        body: ScaffoldBody(controller: controller),
        floatingActionButton: ScaffoldFab(controller: controller),
      ),
    );
  }
}

class ScaffoldBody extends StatelessWidget {
  final TextEditingController controller;
  const ScaffoldBody({
    required this.controller,
    final key = const ValueKey('ScaffoldBody'),
  }) : super(key: key);

  @override
  Widget build(context) {
    return Center(
      child: TextField(
        controller: controller,
      ),
    );
  }
}

class ScaffoldFab extends StatelessWidget {
  final TextEditingController controller;

  const ScaffoldFab({
    required this.controller,
    final key = const ValueKey('ScaffoldFab'),
  }) : super(key: key);

  @override
  Widget build(context) => FloatingActionButton(
        onPressed: _onPressed(context, controller.text),
        child: const Icon(Icons.forward),
      );
}
