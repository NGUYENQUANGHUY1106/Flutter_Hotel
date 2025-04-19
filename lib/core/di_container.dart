import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/domain/BaseUrl.dart';
import 'package:book_hotel/data/repository/RepositoryAuth.dart';
import 'package:book_hotel/data/repository/RepositoryDetailHotel.dart';
import 'package:book_hotel/data/repository/RepositoryHotelIndex.dart';
import 'package:book_hotel/data/repository/RepositoryHotelSignUp.dart';
import 'package:book_hotel/data/repository/RepositoryIndexUser.dart';
import 'package:book_hotel/data/repository/RepositorySignUp.dart';
import 'package:book_hotel/data/repository/RepositoryUserDetailBooked.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(() {
    Dio dio = Dio(BaseOptions(baseUrl: BaseUrl.baseUrl));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String? token = sl<SharedPreferences>().getString(UtilConst.token);
        if (token != null && token.isNotEmpty) {
          print(token);
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    ));

    return dio;
  });

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  await sl.allReady();

  sl.registerLazySingleton(
    () => Repositoryhotelsignup(dio: sl(), sharedPreferences: sl()),
  );

  sl.registerLazySingleton(
    () => Repositoryauth(dio: sl(), sharedPreferences: sl()),
  );

  sl.registerLazySingleton(
     () => Repositorysignup(dio: sl(), sharedPreferences: sl()),
  );

  sl.registerLazySingleton(
    () => Repositoryindexuser(dio: sl()),
  );

  sl.registerLazySingleton(
    () => Repositorydetailhotel(dio: sl()),
  );

  sl.registerLazySingleton(
    () => Repositoryuserdetailbooked(dio: sl(), sharedPreferences: sl()),
  );

  sl.registerLazySingleton(
    () => Repositoryhotelindex(dio: sl()),
  );

  // sl.registerLazySingleton(
  //   () => BannerRepository(dio: sl()),
  // );

  // sl.registerLazySingleton(
  //   () => PostRepository(dio: sl()),
  // );
  // sl.registerLazySingleton(
  //   () => ServiceCategoryRepository(dio: sl()),
  // );
  // sl.registerLazySingleton(
  //   () => WorkScheduleRepository(dio: sl()),
  // );
  // sl.registerLazySingleton(
  //   () => ServiceRequestRepository(dio: sl()),
  // );
  // sl.registerLazySingleton(
  //   () => AuthRepository(dio: sl(), sharedPreferences: sl()),
  // );

  // sl.registerLazySingleton(
  //   () => BankingRepository(dio: sl()),
  // );

  // sl.registerLazySingleton(
  //   () => StateRequestRepository(dio: sl()),
  // );
}
