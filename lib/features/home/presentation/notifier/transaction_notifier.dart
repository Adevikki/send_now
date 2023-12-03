import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/data/model/transaction_model.dart';
import 'package:send_now_test/data/transaction_repository.dart';

class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  final TransactionRepository _repository;

  TransactionNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> fetchTransactions() async {
    state = const AsyncValue.loading();
    try {
      final transactions = await _repository.fetchTransactions();
      state = AsyncValue.data(transactions);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final transactionNotifierProvider =
    StateNotifierProvider<TransactionNotifier, AsyncValue<List<Transaction>>>(
        (ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return TransactionNotifier(repository);
});
