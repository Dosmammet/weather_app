
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:weather_app/feature/domain/usecases/get_city.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_state.dart';
import 'package:weather_app/main.dart';




import '../../../../core/error/failure.dart';


const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class CityCubit extends Cubit<CityState> {
  final GetCity getCity;

  CityCubit({required this.getCity}) : super(CityEmpty());


  void loadCity() async {
    print('loading');
    if (state is CityLoading) return;

    

    emit(CityLoading());

    final failureOrCity = await getCity(GetCityParams(lat: LAT, long: LON));

    failureOrCity.fold((error) => emit(CityError(message: _mapFailureToMessage(error))), (character) {
      emit(CityLoaded(character));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

}