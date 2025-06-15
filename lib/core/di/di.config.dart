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

import '../../feature/todo/data/data_source/local/todo_tracker_local_data.dart'
    as _i469;
import '../../feature/todo/data/data_source/todo_data_source.dart' as _i371;
import '../../feature/todo/data/model/todo_model.dart' as _i237;
import '../../feature/todo/data/repository_impl/todo_repo_impl.dart' as _i942;
import '../../feature/todo/domain/repository/todo_repo.dart' as _i91;
import '../../feature/todo/domain/usecase/add_todo.dart' as _i544;
import '../../feature/todo/domain/usecase/delete_todo.dart' as _i291;
import '../../feature/todo/domain/usecase/filter_todo.dart' as _i894;
import '../../feature/todo/domain/usecase/get_all_todo.dart' as _i752;
import '../../feature/todo/domain/usecase/update_todo.dart' as _i825;
import '../../feature/todo/presentation/bloc/todo_bloc.dart' as _i395;

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
    gh.lazySingleton<_i371.TodoDataSource>(() =>
        _i469.ExpenseTrackerLocalDataSourceImpl(
            gh<_i979.Box<_i237.TodoModel>>()));
    gh.lazySingleton<_i91.TodoRepo>(
        () => _i942.ExpensesRepoImpl(dataSource: gh<_i371.TodoDataSource>()));
    gh.lazySingleton<_i894.FilterTodo>(
        () => _i894.FilterTodo(expenseRepository: gh<_i91.TodoRepo>()));
    gh.lazySingleton<_i825.UpdateTodo>(
        () => _i825.UpdateTodo(expenseRepository: gh<_i91.TodoRepo>()));
    gh.lazySingleton<_i291.DeleteExpense>(
        () => _i291.DeleteExpense(expenseRepository: gh<_i91.TodoRepo>()));
    gh.lazySingleton<_i544.AddTodos>(
        () => _i544.AddTodos(todoRepository: gh<_i91.TodoRepo>()));
    gh.lazySingleton<_i752.GetAllTodo>(
        () => _i752.GetAllTodo(gh<_i91.TodoRepo>()));
    gh.lazySingleton<_i395.TodoBloc>(
      () => _i395.TodoBloc(
        addExpenses: gh<_i544.AddTodos>(),
        getAllExpenses: gh<_i752.GetAllTodo>(),
        updateExpenses: gh<_i825.UpdateTodo>(),
        deleteExpense: gh<_i291.DeleteExpense>(),
        filterExpenses: gh<_i894.FilterTodo>(),
      ),
      instanceName: 'ExpensesBloc',
    );
    return this;
  }
}
