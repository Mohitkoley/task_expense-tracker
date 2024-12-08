// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import '../../feature/expense_tracker/data/data_source/expense_data_source.dart'
    as _i371;
import '../../feature/expense_tracker/data/data_source/local/expence_tracker_local_data.dart'
    as _i469;
import '../../feature/expense_tracker/data/model/expense_model.dart' as _i237;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i371.ExpenseDataSource>(() =>
        _i469.ExpenseTrackerLocalDataSourceImpl(
            gh<_i979.Box<_i237.ExpenseModel>>()));
    return this;
  }
}
