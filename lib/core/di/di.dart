import 'package:bloc_test/core/constants/box_names.dart';
import 'package:bloc_test/feature/expense_tracker/data/model/expense_model.dart';
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
  getIt.registerLazySingleton(
    () => Hive.box<ExpenseModel>(
        name: BoxNames.expenses, encryptionKey: BoxNames.key),
  );
  getIt.init();
}
