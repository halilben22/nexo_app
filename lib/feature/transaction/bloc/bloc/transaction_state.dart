part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionActionState extends TransactionState {}

final class TransactionSavingState extends TransactionState {}

final class TransactionErrorState extends TransactionState {
  final String message;
  TransactionErrorState({required this.message});
}

final class TransactionSuccessState extends TransactionState {
  final String message;
  TransactionSuccessState({required this.message});
}

final class TransactionSuccessShowSnackbarActionState
    extends TransactionActionState {
  final String message;

  TransactionSuccessShowSnackbarActionState({required this.message});
}

final class TransactionErrorShowSnackbarActionState
    extends TransactionActionState {
  final String message;

  TransactionErrorShowSnackbarActionState({required this.message});
}
