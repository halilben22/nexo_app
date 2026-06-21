part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class TransactionSaveEvent extends TransactionEvent {
  final TransactionModel transactionModel;

  TransactionSaveEvent({required this.transactionModel});
}
