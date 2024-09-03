void main() async {
  // print(getData());
  // getData().then((value) => print(value));

  final result = await getData();

  print('end : $result');
}

Future<String> getData() async {
  // 1초 대기
  await Future.delayed(Duration(seconds: 1));
  return 'hello';
}