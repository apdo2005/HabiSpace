 import 'package:flutter/material.dart';

class RemoterErrors {
  static const String invalidUrl = "Invalid URL";
  static const String invalidResponse = "Invalid Response";
  static const String timeout = "Timeout";
  static const String noInternet = "No Internet Connection";
  static const String unknown = "Unknown Error";
  
  static const Map<int, String> httpErrors = {
    400: "Bad Request",
    401: "Unauthorized",
    403: "Forbidden",
    404: "Not Found",
    500: "Internal Server Error",
    502: "Bad Gateway",
    503: "Service Unavailable",
    504: "Gateway Timeout",
  };
   static const Map<String, String> customErrors = {
    invalidUrl: "The provided URL is not valid.",
    invalidResponse: "The server returned an invalid response.",
    timeout: "The request timed out.",
    noInternet: "There is no internet connection.",
    unknown: "An unknown error occurred.",
  };
  Switch (String error) {
    switch (error) {
      case invalidUrl:
        return Text(customErrors[invalidUrl]!);
      case invalidResponse:
        return Text(customErrors[invalidResponse]!);
      case timeout:
        return Text(customErrors[timeout]!);
      case noInternet:
        return Text(customErrors[noInternet]!);
      case unknown:
        return Text(customErrors[unknown]!);
      default:
        return Text(error);
    }
  }
 }