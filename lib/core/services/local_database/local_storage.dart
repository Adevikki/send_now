abstract class LocalStorage {
  Future<void> put(dynamic key, dynamic value);
  T? get<T>(String key);
  dynamic getAt(int key);
  Future<int> add(value);
  Future<int> clear();
  Future<void> delete(value);
  Future<void> putAll(Map<String, dynamic> entries);
}
