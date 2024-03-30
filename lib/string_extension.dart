extension XString on String {
  int get parseToInt =>
      int.parse(replaceAll('.', '').isEmpty ? '0' : replaceAll('.', ''));
}
