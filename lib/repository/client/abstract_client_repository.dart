import 'package:ddx_trainer/repository/abstract_app_repository.dart';
import 'package:ddx_trainer/repository/client/model/client_list_response.dart';

import '../user_repository/model/app_response_model.dart';
import '../user_repository/model/user_response.dart';

abstract class AbstractClientRepository extends AbstractAppRepository {
  AbstractClientRepository({required super.dio});

  Future<AppResponseModel<ClientListResponse>> loadClientList(User user);
}
