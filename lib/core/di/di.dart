import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  // if (!getIt.isRegistered<Box<TodoModel>>()) {
  //   getIt.registerLazySingleton(
  //     () => Hive.box<TodoModel>(
  //         name: BoxNames.expenses, encryptionKey: BoxNames.key),
  //   );
  // }
  String defaultPath = (await getApplicationDocumentsDirectory()).path;
  final isar = Isar.open(
    directory: defaultPath,
    schemas: [TodoModelSchema],
  );
  getIt.registerLazySingleton<Isar>(() => isar);
  getIt.registerLazySingleton<IsarCollection<int, TodoModel>>(
      () => isar.todoModels);
  getIt.init();
}
