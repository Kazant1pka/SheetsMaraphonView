import 'package:maraphons/model/word.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageDataSource {
  StorageDataSource(this._storage);

  final SharedPreferences _storage;

  Future<void> setTableLink(String value) async {
    await _storage.setString('url', value);
  }

  Future<void> setEventName(String value) async {
    await _storage.setString('name', value);
  }

  Future<void> setEventEnd(String value) async {
    await _storage.setString('date', value);
  }

  Future<String> getTableLink() async {
    final link = _storage.getString('url');
    if (link == null) {
      return Word.emptyLink;
    }
    return link;
  }

  Future<String> getEventName() async {
    final name = _storage.getString('name');
    if (name == null) {
      return Word.emptyName;
    }
    return name;
  }

  Future<String> getEventEnd() async {
    final date = _storage.getString('date');
    if (date == null) {
      return Word.emptyDate;
    }
    return date;
  }
}
