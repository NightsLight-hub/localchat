class Config {
  static final Config _inst = Config._internal();

  factory Config() {
    return _inst;
  }

  Config._internal();

  int defaultMessageShowNumber = 50;
  String selfId = 'self';
  String _address = '';
  setAddress(String address) => _address = address;
  String get address => _address;
}
