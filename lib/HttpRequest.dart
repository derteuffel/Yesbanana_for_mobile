import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';



class  HttpRequest {

  static Future<http.Response> fetchJson(String url, Map data) async {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final seconds = 7;
    final client = http.Client();

    try {
      final response = await client.post(
          url, body: json.encode(data), headers: headers);


      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        return response;
      } else {
        // If that response was not OK, throw an error.
        return null;
      }
    } finally {
      client.close();
    }
  }


  static Future<http.Response> getJson(String url) async {

    final seconds = 7;
    final client = http.Client();

    try {
      final response = await client.get(url);


      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        return response;
      } else {
        // If that response was not OK, throw an error.
        return null;
      }
    } finally {
      client.close();
    }
  }
}