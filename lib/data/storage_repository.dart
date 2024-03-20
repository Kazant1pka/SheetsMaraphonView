import 'package:maraphons/data/storage_data.dart';

class StorageRepository {
  StorageRepository(this._storageData);

  final StorageDataSource _storageData;

  Future<void> setLink(String value) async {
    await _storageData.setTableLink(value);
  }

  Future<String> getLink() async {
    return await _storageData.getTableLink();
  }

  Future<void> setName(String value) async {
    await _storageData.setEventName(value);
  }

  Future<String> getName() async {
    return _storageData.getEventName();
  }

  Future<void> setDate(String value) async {
    await _storageData.setEventEnd(value);
  }

  Future<String> getDate() async {
    return _storageData.getEventEnd();
  }
}
