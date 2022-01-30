import 'dart:convert';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request(
      {required Uri url,
      required String method,
      Map<String, dynamic>? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(url, headers: headers, body: jsonBody);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();

    registerFallbackValue(Uri.parse(url));
  });

  group('POST', () {
    test('Should call post with correct values', () async {
      when(() => client.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => Response('{}', 200));

      await sut.request(
          url: Uri.parse(url), method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });
  });
  test('Should call post without body', () async {
    when(() => client.post(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => Response('{}', 200));

    await sut.request(url: Uri.parse(url), method: 'post');

    verify(() => client.post(any(), headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        }));
  });
}
