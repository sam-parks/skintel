import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:skintel/src/services/article_service.dart';
import 'package:skintel/src/services/uv_service.dart';

final GetIt locator = GetIt.instance;

registerLocatorItems(String openUVKey) {
  var firestore = FirebaseFirestore.instance;

  locator.registerSingleton(firestore);
  locator.registerLazySingleton(() => true);
  locator.registerLazySingleton(() => UVService(openUVKey));
  locator.registerLazySingleton(() => ArticleService(firestore));
}
