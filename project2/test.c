int func4() {
  return 3;
}

int func3() {
  return func4();
}

int func2() {
  int a = 10;
  return a;
}

int func1() {
  return func2() + func3();
}

int main(int argc, char** argv) {
  int a = 3;
  func1();

  if (a > 4) {
    func4();
  }

  int b = 4;

  if (b < 5) {
    func1();
  } else {
    func2();
  }

  for (int i = 0; i < b; i++) {
    func1();

    switch (i) {
      case 1:
        func1();
        break;
      case 2:
        func2();
        break;
      case 3:
        func1();
        break;
      default:
        break;
    }
  }

  return 0;
}
