import 'package:flutter/foundation.dart';

class Person {
  final int id;
  final String name;
  final String email;
  final String url;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.url
  }); 

  factory Person.fromJson(Map<String,dynamic> json){
    return  Person(
      id:json['id'] as int,
      name: json['name'] as String,
      email:json['email'] as String,
      url:json['url'] as String
     );
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'url':url
    };
  }

}