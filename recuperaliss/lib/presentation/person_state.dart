import 'package:equatable/equatable.dart';
import 'package:recuperaliss/model/person_model.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState{}

class PersonLoading extends PersonState{}

class PersonSuccess extends PersonState{
  final List<Person> people;
  const PersonSuccess({required this.people});

  @override
  List<Object> get props => [people];
}

class PersonError extends PersonState{
  final String message;
  const PersonError({required this.message});

  @override
  List<Object> get props => [message];
}