import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/constants/constants.dart';

part 'providers.g.dart';

// Appwrite

@riverpod
Client appwriteClient(AppwriteClientRef ref) {
  return Client()
      .setEndpoint(AppwriteConstants.endPoint)
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned();
}

@riverpod
Account appwriteAccount(AppwriteAccountRef ref) {
  final client = ref.watch(appwriteClientProvider);

  return Account(client);
}

@riverpod
Databases appwriteDatabase(AppwriteDatabaseRef ref) {
  final client = ref.watch(appwriteClientProvider);

  return Databases(client);
}

@riverpod
Functions appwriteFunction(AppwriteFunctionRef ref) {
  final client = ref.watch(appwriteClientProvider);

  return Functions(client);
}

@riverpod
Storage appwriteStorage(AppwriteStorageRef ref) {
  final client = ref.watch(appwriteClientProvider);

  return Storage(client);
}

@riverpod
Realtime appwriteRealtime(AppwriteRealtimeRef ref) {
  final client = ref.watch(appwriteClientProvider);

  return Realtime(client);
}
