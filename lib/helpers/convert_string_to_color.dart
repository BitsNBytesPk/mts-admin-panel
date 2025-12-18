import 'dart:ui';

Color parseColorString(String s) {
  final regex = RegExp(r'alpha:\s*([\d.]+).*?red:\s*([\d.]+).*?green:\s*([\d.]+).*?blue:\s*([\d.]+)');
  final match = regex.firstMatch(s);
  if (match == null) throw FormatException('Invalid color format');

  final a = double.parse(match.group(1)!);
  final r = double.parse(match.group(2)!) * 255;
  final g = double.parse(match.group(3)!) * 255;
  final b = double.parse(match.group(4)!) * 255;

  return Color.fromRGBO(r.round(), g.round(), b.round(), a);
}