import 'dart:convert';
import 'dart:developer';

import 'package:branch_manager/module/branch/model/branch.dart';

import '../usage_criteria.dart';

import 'user_data.dart';

class User implements UsageCriteria {
  const User({this.token, this.data, this.branch});

  final String token;
  final UserData data;
  final Branch branch;

  User copyWith({
    String token,
    UserData usermodel,
    Branch branch,
  }) {
    try {
      return User(
        token: token ?? this.token,
        data: usermodel ?? data,
        branch: branch ?? this.branch,
      );
    } catch (e) {
      log('Exception in User.copyWith : $e');
      return const User();
    }
  }

  factory User.fromJson(String str) {
    if (str == null || str.isEmpty) return const User();

    try {
      return User.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in User.fromJson : $e');
      return const User();
    }
  }

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const User();

      return User(
        token: json['token'] as String,
        data: UserData.fromMap(json['usermodel'] as Map<String, dynamic>),
        branch: Branch.fromMap(json['branchmodel'] as Map<String, dynamic>),
      );
    } catch (e) {
      log('Exception in User.fromMap : $e');
      return const User();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'token': token,
        'usermodel': data?.toMap(),
        'branchmodel': branch?.toMap(),
      };
    } catch (e) {
      log('Exception in User.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in User.unusable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return token != null && data != null && data.id != null;
    } catch (e) {
      log('Exception in User.usable : $e');
      return false;
    }
  }
}
