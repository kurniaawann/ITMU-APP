import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile_itmu/framework/core/config/string_resource.dart';
import 'package:mobile_itmu/framework/core/exceptions/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case BadRequestFailure _:
      printError(failure.message.runtimeType);
      if (failure.message is Map<String, dynamic>) {
        return (failure.message as Map<String, dynamic>).values.toString();
      } else if (failure.message is List) {
        return (failure.message as List).join('\n');
      }
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.BAD_REQUEST_FAILURE_MESSAGE;
    case UnauthorisedFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.UNAUTHORISED_FAILURE_MESSAGE;
    case NotFoundFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.NOT_FOUND_MESSAGE;
    case FetchDataFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.FETCH_DATA_FAILURE_MESSAGE;
    case InvalidCredentialFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.INVALID_CREDENTIAL_FAILURE_MESSAGE;
    case ServerFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.SERVER_FAILURE_MESSAGE;
    case AuthenticationFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.AUTHENTICATION_FAILURE_MESSAGE;
    case NetworkFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.NETWORK_FAILURE_MESSAGE;
    case NotAcceptableFailure _:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : StringResources.AUTHENTICATION_PROBLEM_MESSAGE;
    default:
      return (failure.message is String) && failure.message.isNotEmpty
          ? failure.message
          : 'Unexpected error';
  }
}

void printWarning(dynamic text) {
  if (kDebugMode) {
    log('\x1B[33m$text\x1B[0m');
  }
}

void printError(dynamic text) {
  if (kDebugMode) {
    log('\x1B[31m$text\x1B[0m');
  }
}
