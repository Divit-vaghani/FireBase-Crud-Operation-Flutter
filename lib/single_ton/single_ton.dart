class Singleton {
  Singleton._internal();

  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  late String userDoc;
}
