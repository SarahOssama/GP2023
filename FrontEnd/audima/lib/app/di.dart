import 'package:audima/app/app_prefrences.dart';
import 'package:audima/data/data_source/remote_data_source.dart';
import 'package:audima/data/network/app_api.dart';
import 'package:audima/data/network/dio_factory.dart';
import 'package:audima/data/network/network_info.dart';
import 'package:audima/data/repository/repository_impl.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/businessInfo_usecase.dart';
import 'package:audima/domain/usecase/edit_video_usecase.dart';
import 'package:audima/domain/usecase/login_usecase.dart';
import 'package:audima/domain/usecase/pre_edit_video_usecase.dart';
import 'package:audima/domain/usecase/upload_video_usecase.dart';
import 'package:audima/presentaion/business_info/viewmodel/business_info_viewmodel.dart';
import 'package:audima/presentaion/business_video/view/business_video_view.dart';
import 'package:audima/presentaion/business_video/viewmodel/business_video_viewmodel.dart';
import 'package:audima/presentaion/login/viewmodel/login_viewmodel.dart';
import 'package:audima/presentaion/mission_statement/viewmodel/mission_statement_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module where we put all generic dependincies
  final sharedPreferences = await SharedPreferences.getInstance();

  //shared pref instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //app pref instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionCheckerPlus()));

  //dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //appservice client instance
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance
      .registerLazySingleton<VideoServiceClient>(() => VideoServiceClient(dio));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance(), instance()));
  //repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

void initLoginModule() {
  //check if login usecase is not registered
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    //register login usecase
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    //register login viewmodel
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

void initMissionStatementModule() {
  //check if mission statement usecase is not registered
  if (!GetIt.I.isRegistered<MissionStatementUseCase>()) {
    //register mission statement usecase
    instance.registerFactory<MissionStatementUseCase>(
        () => MissionStatementUseCase(instance()));
    //register mission statement viewmodel
    instance.registerFactory<MissionStatementViewModel>(
        () => MissionStatementViewModel(instance()));
  }
}

//init for video upload module
void initVideoUploadModule() {
  //check if upload video usecase is not registered
  if (!GetIt.I.isRegistered<UploadVideoUseCase>()) {
    //register upload video usecase
    instance.registerFactory<UploadVideoUseCase>(
        () => UploadVideoUseCase(instance()));
    //register edit video usecase
    instance
        .registerFactory<EditVideoUseCase>(() => EditVideoUseCase(instance()));
    //register pre edit video usecase
    instance.registerFactory<PreEditVideoUseCase>(
        () => PreEditVideoUseCase(instance()));
    //register mission statement viewmodel
    instance.registerFactory<BusinessVideoViewModel>(
        () => BusinessVideoViewModel(instance(), instance()));
  }
}
