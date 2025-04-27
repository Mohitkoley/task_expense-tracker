// import 'package:bloc_test/core/constants/api_endpoints.dart';
// import 'package:bloc_test/core/network/http_client/network/http_client.dart';
// import 'package:bloc_test/feature/expense_tracker/data/data_source/expense_data_source.dart';
// import 'package:bloc_test/feature/expense_tracker/data/model/category_model.dart';
// import 'package:bloc_test/feature/expense_tracker/domain/entity/expense.dart';

// class AssesmentRemoteDataSourceImpl implements ExpenseDataSource {
//   final HttpClient httpClientService;

//   AssesmentRemoteDataSourceImpl({required this.httpClientService});

//   @override
//   Future<List<ExpenseModel>> getAllExpenses() async {
//     List<ExpenseModel> pixaImageData = [];
//     try {
//       final response =
//           await httpClientService.getGetApiResponse(ApiEndPoint.baseUrl, {});
//       ExpenseModel pixaImagesModel = ExpenseModel.fromJson(response);
//       pixaImageData = [pixaImagesModel];
//     } on Exception {
//       rethrow;
//     }
//     return pixaImageData;
//   }

//   @override
//   Future<List<ExpenseModel>> addExpenses(ExpenseEntity expenseEntity) {
//     // TODO: implement addExpenses
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<ExpenseModel>> deleteExpense(
//       int index, ExpenseEntity expenseEntity) {
//     // TODO: implement deleteExpense
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<ExpenseModel>> filterExpense(
//       {required DateTime date, required ExpenseCategory category}) {
//     // TODO: implement filterExpense
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<ExpenseModel>> updateExpense(
//       int index, ExpenseEntity expenseEntity) {
//     // TODO: implement updateExpense
//     throw UnimplementedError();
//   }
// }
