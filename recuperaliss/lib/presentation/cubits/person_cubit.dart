import 'package:bloc/bloc.dart';
import 'package:recuperaliss/model/person_model.dart';
import 'package:recuperaliss/presentation/person_state.dart';
import 'package:recuperaliss/repository/person_repository.dart';
import 'package:recuperaliss/model/person_model.dart';
import 'dart:convert';

class PersonCubit extends Cubit<PersonState>  {
    final PersonRepository personRepository;
    PersonCubit({required this.personRepository}) : super(PersonInitial());

    Future<void> getPeople() async {
    try {
      emit(PersonLoading());
      
      // Obtener la lista de personas del repositorio
      final people = await personRepository.getPeople();

      // Emitir el estado de éxito con la lista de personas
      emit(PersonSuccess(people: people));
    } catch (e) {
      emit(PersonError(message: e.toString()));
    }
  }

    Future <void> savePerson(Person newPerson) async {
      try {
        emit(PersonLoading());
        await personRepository.savePerson(newPerson);
        getPeople();
      } catch (e) {
        emit(PersonError(message: e.toString()));
      }
    }

    Future <void> updatePerson(Person person) async{
      try {
        emit(PersonLoading());
        await personRepository.updatePerson(person);
        getPeople();
      } catch (e) {
        emit(PersonError(message: e.toString()));
      }
    }

    Future <void> deletePerson(int id) async {
      try {
        emit(PersonLoading());
        await personRepository.deletePerson(id);
        getPeople();
      } catch (e) {
        emit(PersonError(message: e.toString()));
      }
    }


}