import 'package:ddx_trainer/repository/client/client_repository.dart';
import 'package:ddx_trainer/repository/exercise/exercise_repository.dart';
import 'package:ddx_trainer/repository/msg/abstract_msg_repository.dart';
import 'package:ddx_trainer/repository/msg/msg_repository.dart';
import 'package:ddx_trainer/repository/task/abstract_task_repository.dart';
import 'package:ddx_trainer/repository/task/task_repository.dart';
import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/repository/user_repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../repository/client/abstract_client_repository.dart';
import '../repository/exercise/abstract_exercise_repository.dart';

class Di {
  static void initDi(Dio dio) {
    GetIt.I
        .registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

    GetIt.I.registerLazySingleton<AbstractUserRepository>(() =>
        UserRepository(storage: GetIt.I<FlutterSecureStorage>(), dio: dio));

    GetIt.I.registerLazySingleton<AbstractExerciseRepository>(
        () => ExerciseRepository(dio: dio));

    GetIt.I.registerLazySingleton<AbstractClientRepository>(
        () => ClientRepository(dio: dio));

    GetIt.I.registerLazySingleton<AbstractTaskRepository>(
        () => TaskRepository(dio: dio));

    GetIt.I.registerLazySingleton<AbstractMsgRepository>(
        () => MsgRepository(dio: dio));
  }
}
