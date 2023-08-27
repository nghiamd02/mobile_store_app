import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/home_state.dart';
import 'package:mobile_store_app/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(InitHomeState());

  Future<void> fetchNew() async {
    emit(LoadingHomeState());
    try{
      final response = await _homeRepository.getNew();
      emit(ResponseHomeState(response));
    }
    catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }
}