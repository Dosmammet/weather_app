import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';



import 'package:http/http.dart' as http;
import 'package:weather_app/feature/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/feature/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/feature/domain/repository/weather_repository.dart';
import 'package:weather_app/feature/domain/usecases/get_city.dart';
import 'package:weather_app/feature/domain/usecases/get_daily_weather.dart';
import 'package:weather_app/feature/domain/usecases/get_hourly_weather.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_hourly_cubit/weather_hourly_cubit.dart';

import 'core/platform/network_info.dart';
import 'feature/data/repository/weather_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(
    () => WeatherDailyCubit(getDailyWeather: sl()),
  );
  sl.registerFactory(
    () => WeatherHourlyCubit(getHourlyWeather: sl()),
  );
   sl.registerFactory(
    () => CityCubit(getCity: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetDailyWeather(weatherRepository: sl()));
  sl.registerLazySingleton(() => GetHourlyWeather(weatherRepository: sl()));
    sl.registerLazySingleton(() => GetCity(weatherRepository: sl()));
  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );

  // External
  final  sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
