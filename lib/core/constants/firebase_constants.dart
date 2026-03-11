class FirebaseConstants {
  static const String oid = 'oid';
  static const String uid = 'uid';
  static const String from = 'from';
  static const String to = 'to';
  static const String description = 'description';
  static const String weight = 'weight';
  static const String price = 'price';
  static const String createdAt = 'createdAt';
  static const String name = 'name';
  static const String placeId = 'placeId';
  static const String lat = 'lat';
  static const String lng = 'lng';
  static const String localizedNames = 'localizedNames';
  static const String status = 'status';
  static const String isArchive = 'isArchive';

  static const String surname = 'surname';
  static const String role = 'role';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String imageUrl = 'imageUrl';

  // static const String statusPending = 'pending';
  // static const String statusActive = 'active';
}

class FirebaseCollections {
  static const String orders = 'orders';
  static const String users = 'users';
}

class StoragePath {
  static const String usersAvatar = 'users';
  static const String avatarFileName = 'avatar.jpg';
}

class FirebaseErrorsCodes {
  static const String emailInUse = 'email-already-in-use';

  static const String invalidEmail = 'invalid-email';

  static const String weekPassword = 'weak-password';

  static const String userNotFound = 'user-not-found';

  static const String wrongPassword = 'wrong-password';

  static const String invalidCredential = 'invalid-credential';

  static const String tooManyRequests = 'too-many-requests';

  static const String primissionDenied = 'permission-denied';

  static const String notFound = 'not-found';

  static const String unavailable = 'unavailable';

  static const String networkError = 'network-error';
}
