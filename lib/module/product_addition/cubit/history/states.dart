import 'package:branch_manager/main_imports.dart';

abstract class VariantHistoryStates {
  const VariantHistoryStates();
}

class InitState extends VariantHistoryStates {
  const InitState() : super();
}

class FetchingDataState extends VariantHistoryStates {
  const FetchingDataState() : super();
}

class FetchedDataState extends VariantHistoryStates {
  const FetchedDataState() : super();
}

class IneffectiveErrorState extends VariantHistoryStates {
  const IneffectiveErrorState({@required this.error})
      : assert(error != null, 'error must not be null'),
        super();
  final String error;
}

class ExceptionState extends VariantHistoryStates {
  const ExceptionState({@required this.error})
      : assert(error != null, 'error must not be null'),
        super();
  final String error;
}
