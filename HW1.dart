import 'dart:io';

int sum(int n) {
  if (n < 0) return n;

  int s = 0;
  while (n > 0) {
    s += n % 10;
    n ~/= 10;
  }
  return s;
}

void main() {
  while (true) {
    print("숫자를 입력하세요:");
    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) 
      break;
    int num = int.parse(input);
    print("결과: ${sum(num)}");
  }
}