import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_itmu/framework/core/logger/config_logger.dart';

class EnvConfig {
  //base url
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? logger().e('Base Url Not Fond');
  static String get baseUrlAddress =>
      dotenv.env['BASE_URL_ADDRESS'] ?? logger().e('Base Url addess Not Fond');
  //Configurasi error api
  static String get messageErrorApi =>
      dotenv.env['MESSAGE_ERROR_API'] ??
      logger().e('message error api Not Fond');

  static String get messageConnectionInactive =>
      dotenv.env['MESSAGE_CONNECTION_INACTIVE'] ??
      logger().e('message connection inactive Not Fond');
  static String get messageSnackbarError =>
      dotenv.env['MESSAGE_SNACKBAR_ERROR'] ??
      logger().e('message snackbar error Not Fond');

  // ConfigTimeOut
  static String get timeOut =>
      dotenv.env['TIMEOUT'] ?? '15'; // Provide a default value if not set
  static int get seconds => int.parse(timeOut);
  static String get messageTimeout => 'The time required is too long';

  //Firebase Cloud Messageing SetUP
  static String get firebaseApiKey =>
      dotenv.env['FIREBASE_API_KEY'] ??
      logger().e('Firebase API KEY Not Found');
  static String get firebaseAuthenticationDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ??
      logger().e('Firebase Auth Domain Not Found');
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ??
      logger().e('Firebase Project Id Not Found');
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ??
      logger().e('Firebase Storage Bucket Not Found');
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ??
      logger().e('Firebase Messaging Sender Id Not Found');
  static String get firebaseAppId =>
      dotenv.env['FIREBASE_APP_ID'] ?? logger().e('Firebase App Id Not Found');
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ??
      logger().e('Firebase Measurement Id Not Found');
//version
  static String get versionApp => dotenv.env['VERSION'] ?? '2.0.0';
}
