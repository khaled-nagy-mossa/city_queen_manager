import 'package:branch_manager/main_imports.dart';

abstract class DeliveriesStates {
  const DeliveriesStates();
}

class InitialState extends DeliveriesStates {
  const InitialState() : super();
}

class FetchingDataState extends DeliveriesStates {
  const FetchingDataState() : super();
}

class FetchedDataState extends DeliveriesStates {
  const FetchedDataState() : super();
}

class IneffectiveErrorState extends DeliveriesStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}
