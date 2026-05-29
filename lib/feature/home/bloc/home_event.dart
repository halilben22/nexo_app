part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

abstract class HomeActionEvent extends HomeEvent {}

abstract class NavigateToPaymentPageEvent extends HomeActionEvent {}
