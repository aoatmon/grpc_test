// source `https://github.com/grpc/grpc-dart/blob/master/example/helloworld/bin/server.dart`

import 'package:grpc/grpc.dart';
import '../protos/all.dart';

class GreeterService extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    return HelloReply()..message = 'Hello, ${request.name}!';
  }
}

void main() {
  Future<void> main(List<String> args) async {
    final server = Server(
      [GreeterService()],
      const <Interceptor>[],
      CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    );
    await server.serve(port: 50051);
    print('Server listening on port ${server.port}...');
  }
}
