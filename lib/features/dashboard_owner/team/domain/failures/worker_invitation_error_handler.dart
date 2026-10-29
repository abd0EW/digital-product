import 'package:digital_product/core/errors/app_fail.dart';

class WorkerInvitationErrorHandler {
  const WorkerInvitationErrorHandler._();

  static String handle(AppFail fail) {
    final code = fail.code?.toLowerCase().trim();
    final message = fail.message.toLowerCase().trim();

    switch (code) {
      // Auth / Permission
      case '401':
      case 'unauthorized':
        return 'Your session has expired. Please sign in again.';

      case '403':
      case 'forbidden':
        return 'You do not have permission to perform this action.';

      // Validation
      case '400':
      case 'bad_request':
        return _handleBadRequest(message);

      // Worker not found
      case '404':
      case 'not_found':
      case 'worker_not_found':
        return 'Worker not found.';

      // Conflict
      case '409':
      case 'conflict':
        return _handleConflict(message);

      // Rate limit
      case '429':
      case 'too_many_requests':
        return 'Too many requests. Please try again later.';

      // Server errors
      case '500':
      case 'internal_server_error':
        return 'Something went wrong on the server. Please try again.';

      case '502':
      case 'bad_gateway':
      case '503':
      case 'service_unavailable':
        return 'The service is temporarily unavailable. Please try again later.';

      case '504':
      case 'gateway_timeout':
        return 'The request took too long. Please try again.';

      // App-defined codes
      case 'worker_already_invited':
        return 'This email already exists';

      case 'invitation_already_exists':
        return 'An invitation has already been sent to this worker.';

      case 'invitation_expired':
        return 'This invitation has expired';

      case 'invalid_invitation':
        return 'The invitation is invalid';

      case 'invitation_not_found':
        return 'Invitation not found';

      case 'invalid_email':
        return 'Please enter a valid email address';

      case 'email_required':
        return 'Email is required';

      case 'worker_already_exists':
        return 'This worker already belongs to the workspace';

      case 'owner_cannot_be_invited':
        return 'The workspace owner cannot be invited as a worker';

      case 'cannot_invite_yourself':
        return 'You cannot invite yourself';

      case 'workspace_not_found':
        return 'Workspace not found';

      case 'network_error':
      case 'socket_exception':
        return 'No internet connection. Please check your connection and try again';

      case 'timeout':
      case 'timeout_exception':
        return 'The request timed out. Please try again.';

      default:
        return _handleMessage(message);
    }
  }

  static String _handleBadRequest(String message) {
    if (message.contains('email')) {
      return 'Please enter a valid email address.';
    }

    if (message.contains('worker')) {
      return 'Invalid worker information.';
    }

    if (message.contains('invitation')) {
      return 'Invalid invitation request.';
    }

    return 'Invalid request. Please check the entered data.';
  }

  static String _handleConflict(String message) {
    if (message.contains('already invited')) {
      return 'This worker has already been invited.';
    }

    if (message.contains('already exists')) {
      return 'This worker already exists.';
    }

    if (message.contains('duplicate')) {
      return 'This invitation already exists.';
    }

    return 'This operation conflicts with existing data.';
  }

  static String _handleMessage(String message) {
    if (message.contains('already invited')) {
      return 'This worker has already been invited.';
    }

    if (message.contains('already exists')) {
      return 'This worker already exists.';
    }

    if (message.contains('invalid email')) {
      return 'Please enter a valid email address.';
    }

    if (message.contains('not found')) {
      return 'Worker or invitation not found.';
    }

    if (message.contains('permission') ||
        message.contains('not authorized') ||
        message.contains('unauthorized')) {
      return 'You do not have permission to perform this action.';
    }

    if (message.contains('network') ||
        message.contains('socket') ||
        message.contains('connection')) {
      return 'No internet connection. Please try again.';
    }

    if (message.contains('timeout')) {
      return 'The request timed out. Please try again.';
    }

    return 'Worker invitation operation failed. Please try again.';
  }
}
