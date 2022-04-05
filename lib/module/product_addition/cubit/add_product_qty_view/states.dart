import 'package:flutter/material.dart';

abstract class AddProductQtyStates {
  const AddProductQtyStates();
}

class InitialState extends AddProductQtyStates {
  const InitialState() : super();
}

class LoadingState extends AddProductQtyStates {
  const LoadingState() : super();
}

class QtyUpdatedState extends AddProductQtyStates {
  final String msg;

  const QtyUpdatedState({@required this.msg}) : super();
}

class IneffectiveState extends AddProductQtyStates {
  final String error;

  const IneffectiveState({@required this.error}) : super();
}
