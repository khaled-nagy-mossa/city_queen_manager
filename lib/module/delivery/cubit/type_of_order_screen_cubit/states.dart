import 'package:flutter/cupertino.dart';

abstract class DriverTypeOgOrderScreenStates {
  const DriverTypeOgOrderScreenStates();
}

class InitialState extends DriverTypeOgOrderScreenStates {
  const InitialState() : super();
}

class HasInitState extends DriverTypeOgOrderScreenStates {
  const HasInitState() : super();
}

class EmptyState extends DriverTypeOgOrderScreenStates {
  const EmptyState() : super();
}

class LoadingState extends DriverTypeOgOrderScreenStates {
  const LoadingState() : super();
}

class FetchingDataState extends DriverTypeOgOrderScreenStates {
  const FetchingDataState() : super();
}

class IneffectiveErrorState extends DriverTypeOgOrderScreenStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends DriverTypeOgOrderScreenStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
