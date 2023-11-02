validatePassword(String val) {
  if (val.isEmpty) {
    return 1;
  } else if (val.length > 7) {
    return 0;
  } else {
    return 2;
  }
}
