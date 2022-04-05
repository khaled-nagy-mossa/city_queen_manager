import 'dart:convert';

import '../../chat/common/conversation_view_imports.dart';

class Glance {
  const Glance({
    this.online,
    this.inBranch,
  });

  final String online;
  final String inBranch;

  Glance copyWith({
    String online,
    String inBranch,
  }) {
    try {
      return Glance(
        online: online ?? this.online,
        inBranch: inBranch ?? this.inBranch,
      );
    } catch (e) {
      log('Exception in Glance.copyWith : $e');
      return this;
    }
  }

  factory Glance.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) {
        return const Glance();
      }
      return Glance.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in Glance.fromJson : $e');
      return const Glance();
    }
  }

  String toJson() => json.encode(toMap());

  factory Glance.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) {
        return const Glance();
      }
      return Glance(
        online: json['online'] as String,
        inBranch: json['in_branch'] as String,
      );
    } catch (e) {
      log('Exception in Glance.fromMap : $e');
      return const Glance();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'online': online,
        'in_branch': inBranch,
      };
    } catch (e) {
      log('Exception in Glance.toMap : $e');
      return <String, dynamic>{};
    }
  }
}
