import 'dart:convert';
import 'package:recuperaliss/model/person_model.dart';
import 'package:http/http.dart' as http;

class PersonRepository {
  final String baseURL = 'https://reqres.in/api/users';

  PersonRepository();

  Future<List<Person>> getPeople() async {
    try {
      final response = await http.get(Uri.parse('$baseURL?page=2'));

      // Imprime el cuerpo de la respuesta para depuración
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Imprime la estructura del JSON decodificado
        print('Decoded JSON: $jsonResponse');

        if (jsonResponse['data'] is List) {
          List<dynamic> peopleJson = jsonResponse['data'];
          List<Person> people = peopleJson.map((person) => Person.fromJson(person)).toList();
          return people;
        } else {
          throw Exception('La clave "data" no es una lista');
        }
      } else {
        throw Exception('Error al recuperar las personas');
      }
    } catch (e) {
      print('Error en getPeople: $e');
      throw Exception('Failed to fetch people');
    }
  }

  Future<void> savePerson(Person newPerson) async {
    try {
      final response = await http.post(
        Uri.parse(baseURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newPerson.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to save person');
      }
    } catch (e) {
      print('Error en savePerson: $e');
      throw Exception('Failed to save person');
    }
  }

  Future<void> updatePerson(Person person) async {
    try {
      final response = await http.put(
        Uri.parse('$baseURL/${person.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update person');
      }
    } catch (e) {
      print('Error en updatePerson: $e');
      throw Exception('Failed to update person');
    }
  }

  Future<void> deletePerson(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseURL/$id'));
      if (response.statusCode != 204) {
        throw Exception('Failed to delete person');
      }
    } catch (e) {
      print('Error en deletePerson: $e');
      throw Exception('Failed to delete person');
    }
  }
}
