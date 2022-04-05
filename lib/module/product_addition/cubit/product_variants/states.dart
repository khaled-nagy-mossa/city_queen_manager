import 'package:flutter/material.dart';

abstract class ProductVariantsStates {
  const ProductVariantsStates();
}

class InitialState extends ProductVariantsStates {
  const InitialState() : super();
}

class HasInitState extends ProductVariantsStates {
  const HasInitState() : super();
}

class LoadingState extends ProductVariantsStates {
  const LoadingState() : super();
}

class IneffectiveErrorState extends ProductVariantsStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends ProductVariantsStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
