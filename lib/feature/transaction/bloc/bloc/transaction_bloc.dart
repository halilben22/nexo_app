import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nexo_app/feature/transaction/repo/transaction_repo.dart';
import 'package:nexo_app/models/transaction_model.dart';
import 'package:nexo_app/repo/firebase_repo.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepo transactionRepo;
  final FirebaseRepo firebaseRepo;
  TransactionBloc(this.transactionRepo, this.firebaseRepo)
    : super(TransactionInitial()) {
    on<TransactionSaveEvent>((event, emit) async {
      emit(TransactionSavingState());

      try {
        final id = firebaseRepo.createId();

        final model = event.transactionModel.copyWith(id: id);

        await transactionRepo.addTransaction(model);
        emit(
          TransactionSuccessState(message: "Transaction added successfully!"),
        );

        emit(
          TransactionSuccessShowSnackbarActionState(
            message: "Transaction added successfully!",
          ),
        );
      } catch (e) {
        emit(TransactionErrorState(message: "Transaction failed!"));
        emit(
          TransactionErrorShowSnackbarActionState(
            message: "Transaction failed!",
          ),
        );
      }
    });
  }
}
