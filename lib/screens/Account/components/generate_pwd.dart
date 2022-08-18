import 'dart:math';

String generatePassword() {
  final length = 8;
  final lettersLowercase = 'abcdefghijklmnopqrstuvwxyz';
  final lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final numbers = '0123456789';
  final special = '!@#%^&*\$()+}{?';

  String chars = '';
  chars += '$lettersUppercase$lettersLowercase';
  chars += '$numbers';
  chars += '$special';

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
  // final indexRandom = Random().nextInt(chars.length);
}

String generateNameApp() {
  final length = 20;
  final lettersLowercase = 'abcdefghijklmnopqrstuvwxyz';
  final lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final numbers = '0123456789';
  final special = '!@#%^&*\$()+}{?';

  String chars = '';
  chars += '$lettersUppercase$lettersLowercase';
  chars += '$numbers';
  chars += '$special';

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
  // final indexRandom = Random().nextInt(chars.length);
}
