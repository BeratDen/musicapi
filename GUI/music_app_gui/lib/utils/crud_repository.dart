import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/api_client.dart';
import 'package:intl/intl.dart';

/// The `CrudRepository` class provides CRUD operations (Create, Read, Update, Delete) for interacting with a REST API using
/// a specified base URL and an `ApiClient`.
class CrudRepository<T> {
  final String baseUrl;
  final ApiClient apiClient;

  CrudRepository(this.baseUrl, this.apiClient);

  /// Create operation
  /// The `create` function asynchronously sends a POST request to the API client with a given item and prints the response.
  ///
  /// Args:
  ///   item (Map<String, dynamic>): A map containing key-value pairs where the keys are strings and the values are dynamic
  /// types. This map represents the data of the item that will be created.
  Future<Response<dynamic>> create(Map<String, dynamic> item) async {
    final response = await apiClient.post(baseUrl, item);
    debugPrint('Item created: $response');
    return response;
  }

  // Read List operation
  Future<List<Map<String, dynamic>>> list() async {
    final response = await apiClient.list(baseUrl);
    final List<Map<String, dynamic>> json = jsonDecode(response);
    return json;
  }

  // Read operation
  Future<Map<String, dynamic>> getById(int id) async {
    final response = await apiClient.get('$baseUrl/$id');
    final Map<String, dynamic> json = jsonDecode(response);
    return json;
  }

  // Update operation
  Future<void> update(int id, Map<String, dynamic> updatedItem) async {
    final response = await apiClient.put('$baseUrl/$id', updatedItem);
    debugPrint('Item updated: $response');
  }

  // Delete operation
  Future<void> delete(int id) async {
    final response = await apiClient.delete('$baseUrl/$id');
    debugPrint('Item deleted: $response');
  }
}
