import 'dart:convert';
import 'package:recuperaliss/model/person_model.dart';
import 'package:http/http.dart' as http;

class PersonRepository {
  final String baseURL='https://reqres.in/api/users';


  PersonRepository();

  Future<List<Person>> getPeople() async {
    try {
      final response = await http.get(Uri.parse('$baseURL?page=2'),);
      print(response);
      if(response.statusCode==200){
        List<dynamic> peopleJson= jsonDecode(response.body)['data'];
        List<Person> people=peopleJson.map((person)=> Person.fromJson(person)).toList();
        return people;
      } else {
        throw Exception('error a recperar a las personas');
      }
    } catch (e) {
      print('Error getCars: $e');
      throw Exception('Failed to fetch cars');
    }
  }

  Future<void> savePerson(Person newPerson) async{
    try {
      final response = await http.post(Uri.parse(baseURL),
      body:jsonEncode(newPerson.toJson));
      if (response.statusCode != 201) {
        throw Exception('Failed to save person');
      }
    } catch (e) {
      print('Error saveCar $e');
      throw Exception('Failed to save person');
    }  
  }

  Future <void> updatePerson(Person person) async{
    try {
      final  response =await http.put(Uri.parse('$baseURL${person.id}'),
      body: jsonEncode(person.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update person');
      }
    } catch (e) {
      print('Error updateCar $e');
      throw Exception('Failed to update person');
    }
  }

  Future<void> deletePerson(int id) async{
    try {
      final response = await http.delete(Uri.parse('$baseURL${id}'),);
      if (response.statusCode != 204) {
        throw Exception('Failed to delete person');
      }
    } catch (e) {
      print('Error delete person $e');
      throw Exception('Failed to delete person');
    }
  }
}