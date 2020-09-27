import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:skintel/src/services/article_service.dart';
import 'package:skintel/src/services/uv_service.dart';

final GetIt locator = GetIt.instance;

registerLocatorItems(String openUVKey) {
  var firebaseApp = FirebaseApp.instance;
  var firestore = Firestore(app: firebaseApp);
  firestore.settings(persistenceEnabled: true);
  locator.registerSingleton(firestore);
  locator.registerLazySingleton(() => true);
  locator.registerLazySingleton(() => UVService(openUVKey));
  locator.registerLazySingleton(() => ArticleService(firestore));
}
