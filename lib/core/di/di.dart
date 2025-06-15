import 'package:bloc_test/core/constants/box_names.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  if (!getIt.isRegistered<Box<TodoModel>>()) {
    getIt.registerLazySingleton(
      () => Hive.box<TodoModel>(
          name: BoxNames.expenses, encryptionKey: BoxNames.key),
    );
  }
  getIt.init();
}
