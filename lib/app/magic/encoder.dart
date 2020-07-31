import 'package:osca_dart/app/magic/encoder_keys.dart';
import 'package:osca_dart/app/magic/string_utils.dart';

class Encoder {
  static List<int> byteKey = [
    52,
    48,
    54,
    97,
    54,
    50,
    50,
    50,
    51,
    99,
    55,
    54,
    53,
    52,
    55,
    101,
    51,
    98,
    53,
    101,
    51,
    49,
    53,
    53,
    52,
    48,
    54,
    52,
    53,
    48,
    55,
    101,
    53,
    99,
    50,
    56,
    52,
    101,
    54,
    49,
    54,
    54,
    53,
    48,
    55,
    100,
    50,
    56,
    51,
    57,
    53,
    49,
    50,
    56,
    50,
    52,
    52,
    51
  ];

  static String doMagicWithString(String s) {
    final List<int> arr = StringUtils.toIntArray(s);

    final List<int> ai = Encode(arr);

    //var stuff = StringUtils.convertToString(ai);

    //return StringUtils.toCustomBase64(stuff);

    return StringUtils.toCustomBase64FromIntList(ai);
  }

  static List<int> Encode(List<int> stringAsIntArray) {
    Encoder encoder = new Encoder();

    EncoderKeys encoderKeys = encoder.SecondCalledMethod(byteKey);

    return encoder.ThirdCalledMethod(stringAsIntArray, encoderKeys);
  }

  int DoSomething(int longOne, int longTwo, List<int> arrayOne, int longThree) {
    return longOne & -1 ^
        longThree & -1 ^
        ((arrayOne[(longTwo >> 24) & 0xff] +
                                arrayOne[((longTwo >> 16) & 0xff) + 256] &
                            -1 ^
                        arrayOne[((longTwo >> 8) & 0xff) + 512]) &
                    -1) +
                arrayOne[(longTwo & 255) + 768] &
            -1;
  }

  EncoderKeys SecondCalledMethod(List<int> key) {
    int keyLength = key.length > 72 ? 72 : key.length;

    EncoderKeys encoderKeys = new EncoderKeys();
    int something = 0;

    for (int k = 0; k < encoderKeys.keyOne.length; k++) {
      int l = something + 1;

      int l1 = key[something];

      something = l;
      if (l >= keyLength) {
        something = 0;
      }

      l = something + 1;
      int l2 = key[something];
      something = l;
      if (l >= keyLength) {
        something = 0;
      }
      l = something + 1;

      int l3 = key[something];
      something = l;
      if (l >= keyLength) {
        something = 0;
      }
      l = something + 1;

      int l4 = key[something];
      if (l >= keyLength) {
        something = 0;
      } else {
        something = l;
      }

      encoderKeys.keyOne[k] =
          encoderKeys.keyOne[k] ^ (((l1 << 8 | l2) << 8 | l3) << 8 | l4);
    }

    List<int> longArray = [0, 0];

    for (int index = 0; index < encoderKeys.keyOne.length; index += 2) {
      DoMuchWithEncoderKeys(longArray, encoderKeys);
      encoderKeys.keyOne[index] = longArray[0];
      encoderKeys.keyOne[index + 1] = longArray[1];
    }

    for (int index = 0; index < encoderKeys.keyTwo.length; index += 2) {
      DoMuchWithEncoderKeys(longArray, encoderKeys);
      encoderKeys.keyTwo[index] = longArray[0];
      encoderKeys.keyTwo[index + 1] = longArray[1];
    }
    return encoderKeys;
  }

  List<int> ThirdCalledMethod(
      List<int> stringAsIntArray, EncoderKeys encoderKeys1) {
    List<int> secret = [30, 214, 186, 72, 38, 84, 2, 16];
    int secretIndexCounter = 0;
    List<int> longArray = List<int>(2);

    int length = stringAsIntArray.length;
    List<int> intArray = List<int>(length);
    int counter = length;
    length = 0;

    while (counter > 0) {
      doMagic(encoderKeys1, secret, longArray, secretIndexCounter);

      int newValue = stringAsIntArray[length] ^ secret[secretIndexCounter];

      intArray[length] = newValue;
      secret[secretIndexCounter] = newValue;

      if (secretIndexCounter >= secret.length - 1) {
        secretIndexCounter = 0;
      } else {
        secretIndexCounter = secretIndexCounter + 1;
      }

      length++;
      counter--;
    }

    return intArray;
  }

  void doMagic(EncoderKeys encoderKeys, List<int> secret, List<int> longArray,
      int secretIndex) {
    if (secretIndex != 0) {
      return;
    }

    longArray[0] =
        (secret[0] << 24) | (secret[1] << 16) | (secret[2] << 8) | secret[3];
    longArray[1] =
        (secret[4] << 24) | (secret[5] << 16) | (secret[6] << 8) | secret[7];

    DoMuchWithEncoderKeys(longArray, encoderKeys);

    int l3 = longArray[0];

    secret[0] = (l3 >> 24 & 255);
    secret[1] = (l3 >> 16 & 255);
    secret[2] = (l3 >> 8 & 255);
    secret[3] = (l3 & 255);

    l3 = longArray[1];

    secret[4] = (l3 >> 24 & 255);
    secret[5] = (l3 >> 16 & 255);
    secret[6] = (l3 >> 8 & 255);
    secret[7] = (l3 & 255);
  }

  void DoMuchWithEncoderKeys(List<int> longArray, EncoderKeys encoderKeys) {
    int first = longArray[0];
    int second = longArray[1];
    first = first & -1 ^ encoderKeys.keyOne[0] & -1;
    second = DoSomething(
            second & -1, first, encoderKeys.keyTwo, encoderKeys.keyOne[1]) &
        -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[2]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[3]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[4]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[5]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[6]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[7]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[8]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[9]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[10]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[11]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[12]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[13]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[14]) &
            -1;
    second =
        DoSomething(second, first, encoderKeys.keyTwo, encoderKeys.keyOne[15]) &
            -1;
    first =
        DoSomething(first, second, encoderKeys.keyTwo, encoderKeys.keyOne[16]);

    int lastElement = encoderKeys.keyOne[encoderKeys.keyOne.length - 1];
    longArray[1] = first & -1;
    longArray[0] = (second ^ lastElement & -1) & -1;
  }
}
