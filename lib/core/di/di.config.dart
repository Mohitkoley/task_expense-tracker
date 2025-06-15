// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;

import '../../feature/todo/data/data_source/local/todo_tracker_local_data.dart'
    as _i757;
import '../../feature/todo/data/data_source/todo_data_source.dart' as _i193;
import '../../feature/todo/data/model/todo_model.dart' as _i248;
import '../../feature/todo/data/repository_impl/todo_repo_impl.dart' as _i458;
import '../../feature/todo/domain/repository/todo_repo.dart' as _i969;
import '../../feature/todo/domain/usecase/add_todo.dart' as _i1020;
import '../../feature/todo/domain/usecase/delete_todo.dart' as _i326;
import '../../feature/todo/domain/usecase/filter_todo.dart' as _i806;
import '../../feature/todo/domain/usecase/get_all_complete_todo.dart' as _i403;
import '../../feature/todo/domain/usecase/get_all_uncomplete_todo.dart'
    as _i192;
import '../../feature/todo/domain/usecase/update_todo.dart' as _i1004;
import '../../feature/todo/presentation/bloc/todo_bloc.dart' as _i762;

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
    gh.lazySingleton<_i193.TodoDataSource>(
        () => _i757.ExpenseTrackerLocalDataSourceImpl(
              gh<_i338.IsarCollection<int, _i248.TodoModel>>(),
              gh<_i338.Isar>(),
            ));
    gh.lazySingleton<_i969.TodoRepo>(
        () => _i458.ExpensesRepoImpl(dataSource: gh<_i193.TodoDataSource>()));
    gh.lazySingleton<_i403.GetAllCompleteTodo>(
        () => _i403.GetAllCompleteTodo(gh<_i969.TodoRepo>()));
    gh.lazySingleton<_i192.GetAllUnCompleteTodo>(
        () => _i192.GetAllUnCompleteTodo(gh<_i969.TodoRepo>()));
    gh.lazySingleton<_i1020.AddTodos>(
        () => _i1020.AddTodos(todoRepository: gh<_i969.TodoRepo>()));
    gh.lazySingleton<_i806.FilterTodo>(
        () => _i806.FilterTodo(expenseRepository: gh<_i969.TodoRepo>()));
    gh.lazySingleton<_i1004.UpdateTodo>(
        () => _i1004.UpdateTodo(expenseRepository: gh<_i969.TodoRepo>()));
    gh.lazySingleton<_i326.DeleteExpense>(
        () => _i326.DeleteExpense(expenseRepository: gh<_i969.TodoRepo>()));
    gh.lazySingleton<_i762.TodoBloc>(() => _i762.TodoBloc(
          addExpenses: gh<_i1020.AddTodos>(),
          getAllUnCompletedTodo: gh<_i192.GetAllUnCompleteTodo>(),
          updateExpenses: gh<_i1004.UpdateTodo>(),
          deleteExpense: gh<_i326.DeleteExpense>(),
          filterExpenses: gh<_i806.FilterTodo>(),
          getAllCompletedTodo: gh<_i403.GetAllCompleteTodo>(),
        ));
    return this;
  }
}
