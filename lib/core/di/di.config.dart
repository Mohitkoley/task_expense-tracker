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
import '../../feature/expense_tracker/data/repository_impl/expense_repo_impl.dart'
    as _i942;
import '../../feature/expense_tracker/domain/repository/assesment_repo.dart'
    as _i91;
import '../../feature/expense_tracker/domain/usecase/add_expenses.dart'
    as _i544;
import '../../feature/expense_tracker/domain/usecase/delete_expense.dart'
    as _i291;
import '../../feature/expense_tracker/domain/usecase/filter_expenses.dart'
    as _i894;
import '../../feature/expense_tracker/domain/usecase/get_all_expenses.dart'
    as _i752;
import '../../feature/expense_tracker/domain/usecase/update_expenses.dart'
    as _i825;
import '../../feature/expense_tracker/presentation/bloc/expenses_bloc.dart'
    as _i395;
import '../../feature/worktime_balance/data/repository_implimention/notification_repository_impl.dart'
    as _i76;
import '../../feature/worktime_balance/domain/usecases/schedule_notification_usecase.dart'
    as _i289;
import '../../feature/worktime_balance/exports/worktime_balance_export.dart'
    as _i172;
import '../../feature/worktime_balance/presentation/bloc/time_selection_bloc.dart'
    as _i873;
import '../notification/local_notification_service.dart' as _i380;

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
    gh.lazySingleton<_i172.NotificationRepository>(() =>
        _i76.NotificationRepositoryImpl(
            notificationService: gh<_i380.FlutterLocalNotiServices>()));
    gh.lazySingleton<_i289.ScheduleNotificationsUseCase>(() =>
        _i289.ScheduleNotificationsUseCase(gh<_i172.NotificationRepository>()));
    gh.lazySingleton<_i371.ExpenseDataSource>(() =>
        _i469.ExpenseTrackerLocalDataSourceImpl(
            gh<_i979.Box<_i237.ExpenseModel>>()));
    gh.lazySingleton<_i91.ExpensesRepo>(() =>
        _i942.ExpensesRepoImpl(dataSource: gh<_i371.ExpenseDataSource>()));
    gh.lazySingleton<_i894.FilterExpenses>(
        () => _i894.FilterExpenses(expenseRepository: gh<_i91.ExpensesRepo>()));
    gh.lazySingleton<_i825.UpdateExpenses>(
        () => _i825.UpdateExpenses(expenseRepository: gh<_i91.ExpensesRepo>()));
    gh.lazySingleton<_i291.DeleteExpense>(
        () => _i291.DeleteExpense(expenseRepository: gh<_i91.ExpensesRepo>()));
    gh.lazySingleton<_i544.AddExpenses>(
        () => _i544.AddExpenses(expenseRepository: gh<_i91.ExpensesRepo>()));
    gh.lazySingleton<_i752.GetAllExpenses>(
        () => _i752.GetAllExpenses(gh<_i91.ExpensesRepo>()));
    gh.lazySingleton<_i873.TimeSelectionBloc>(() => _i873.TimeSelectionBloc(
        scheduleNotificationsUseCase:
            gh<_i172.ScheduleNotificationsUseCase>()));
    gh.lazySingleton<_i395.ExpensesBloc>(
      () => _i395.ExpensesBloc(
        addExpenses: gh<_i544.AddExpenses>(),
        getAllExpenses: gh<_i752.GetAllExpenses>(),
        updateExpenses: gh<_i825.UpdateExpenses>(),
        deleteExpense: gh<_i291.DeleteExpense>(),
        filterExpenses: gh<_i894.FilterExpenses>(),
      ),
      instanceName: 'ExpensesBloc',
    );
    return this;
  }
}
