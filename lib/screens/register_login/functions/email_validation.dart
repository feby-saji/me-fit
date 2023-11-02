
validateEmail(String val) {
  if (val.isEmpty) {
    return 1;
  } else if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val)) {
    return 0;
  } else {
    return 2;
  }
}
