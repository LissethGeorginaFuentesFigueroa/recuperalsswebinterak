import 'package:flutter/foundation.dart';

class Person {
  final int id;
  final String name;
  final String email;
  final String avatar;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar
  }); 

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int? ?? 0,
      name: '${json['first_name'] ?? ''} ${json['last_name'] ?? ''}', // Combina first_name y last_name
      email: json['email'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'avatar':avatar
    };
  }

  Person copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

}