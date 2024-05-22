import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void Search(String text) {
    emit(SearchloadingState());
    Dio_Helper.PostinDB(url: search, data: {'text': text},token: token).then((value) {
      model = SearchModel.fromjson(value.data); 
      emit(SearchsuccessState());
    }).catchError((error) {
      emit(SearcherrorState());
      print('error occur search :${error.toString()}');
    });
  }
}
