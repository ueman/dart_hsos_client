import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:osca_dart/app/encryption/integer_polynomial.dart';

import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/export.dart';

class KeyCrypterScrypt {
  static List<int> deriveKey(
    String password,
    List<int> salt,
  ) {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac(sha1),
      iterations: 1000,
      bits: 128,
    );

    final hashBytes =
        pbkdf2.deriveBitsSync(IntegerPolynomial.toBinary(), nonce: Nonce(salt));
    return hashBytes;
  }

  static String encode(List<int> paramArrayOfByte) {
    return base64
        .encode(paramArrayOfByte)
        .replaceAll('\n', '')
        .replaceAll('+', '-')
        .replaceAll('=', '_')
        .replaceAll('/', '~');
  }

  static String encrypt(String plaintext) {
    final password = IntegerPolynomial.key;

    final plaintextBytes = toByteArray(plaintext);
    final secondKey = deriveKey(password, plaintextBytes);

    final passwordDescription = <int>[];
    passwordDescription.addAll(secondKey);
    passwordDescription.addAll(plaintextBytes);

    final secureRandom = CustomSecureRandom();

    final salt = secureRandom.nextBytes(16);
    final firstKey = deriveKey(password, salt);

    final cipher = BlockCipher('AES/CFB-128');
    final initialVector = secureRandom.nextBytes(cipher.blockSize);
    cipher.init(
      true,
      ParametersWithIV(
        KeyParameter(Uint8List.fromList(firstKey)),
        initialVector,
      ),
    );

    // wird im NoPaddingMode ecrypted
    final encryptedContent =
        _processBlocks(cipher, Uint8List.fromList(passwordDescription));

    final outputStream = <int>[];
    outputStream.addAll(initialVector);
    outputStream.addAll(salt);
    outputStream.addAll(encryptedContent);

    return encode(outputStream);
  }

  static Uint8List _processBlocks(BlockCipher cipher, Uint8List input) {
    final inputSize = input.lengthInBytes;
    // wir brauchen das nächste multiple of cipher.blocksize
    final size = cipher.blockSize * (input.lengthInBytes / 16).ceil();

    final inpInt = <int>[];
    inpInt.addAll(input);
    inpInt
        .addAll(Uint8List.fromList(List.generate(size - inputSize, (i) => 0)));

    final inp = Uint8List.fromList(inpInt);
    var out = Uint8List(size);

    for (var offset = 0; offset < inp.lengthInBytes;) {
      var len = cipher.processBlock(inp, offset, out, offset);
      offset += len;
    }

    // nur die Länge von input zurück geben, alle die danach kommen sind eh 0
    return Uint8List.fromList(out.take(inputSize).toList());
  }

  static String md5(String paramString) {
    return crypto.md5
        .convert(toByteArray(paramString))
        .toString()
        .toUpperCase();
  }

  static List<int> toByteArray(String paramString) {
    return utf8.encode(paramString);
  }
}

class CustomSecureRandom {
  Random rnd = Random.secure();

  Uint8List nextBytes(int length) {
    return Uint8List.fromList(
        List<int>.generate(length, (i) => 0 /*rnd.nextInt(256) */));
  }
}
