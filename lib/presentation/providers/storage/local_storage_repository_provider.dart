import 'package:cinemacuenca/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemacuenca/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  (ref) {
    return LocalStorageRepositoryImpl(datasource: IsarDatasource());
  },
);
