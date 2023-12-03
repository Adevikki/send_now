import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/data/model/transaction_model.dart';

class TransactionRepository {
  Future<List<Transaction>> fetchTransactions() async {
    await Future.delayed(const Duration(seconds: 2));
    final transactions = [
      Transaction(id: 'SCP9374826473', status: 'In the process'),
      Transaction(id: 'SCP9374826473', status: 'In the process'),
    ];
    return transactions;
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository();
});
