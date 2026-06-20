part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionActionState extends TransactionState {}

final class TransactionSavingState extends TransactionState {}

final class TransactionSuccessState extends TransactionActionState {
  final String message;

  TransactionSuccessState({required this.message});
}

final class TransactionErrorState extends TransactionActionState {
  final String message;
  TransactionErrorState({required this.message});
}
