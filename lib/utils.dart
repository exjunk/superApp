import 'dart:math';

class Utils {
  static const String alphabet =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random();
  final Set<String> generatedCodes = <String>{};

  String generateCode(int length) {
    String code;
    do {
      code = _generateRandomCode(length);
    } while (generatedCodes.contains(code));
    generatedCodes.add(code);
    return code;
  }

  String _generateRandomCode(int length) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length)),
      ),
    );
  }
}
