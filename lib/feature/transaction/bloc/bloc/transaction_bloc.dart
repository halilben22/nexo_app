import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nexo_app/feature/transaction/repo/transaction_repo.dart';
import 'package:nexo_app/models/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepo transactionRepo;
  TransactionBloc(this.transactionRepo) : super(TransactionInitial()) {
    on<TransactionSaveEvent>((event, emit) async {
      emit(TransactionSavingState());

      try {
        await transactionRepo.addTransaction(event.transactionModel);
        emit(TransactionSuccessState(message: "successfull!"));
      } catch (e) {
        emit(TransactionErrorState(message: e.toString()));
      }
    });
  }
}
