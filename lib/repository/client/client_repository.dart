import 'package:ddx_trainer/repository/client/abstract_client_repository.dart';
import 'package:ddx_trainer/repository/client/model/client_list_response.dart';
import 'package:ddx_trainer/repository/user_repository/model/app_response_model.dart';
import 'package:ddx_trainer/repository/user_repository/model/user_response.dart';
import 'package:dio/dio.dart';

import '../../config.dart';

class ClientRepository extends AbstractClientRepository {
  ClientRepository({required super.dio});

  @override
  Future<AppResponseModel<ClientListResponse>> loadClientList(User user) async {
    final response = await dio.get(
      '${Config.server}/api/clients/',
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: getHeaderWithToken(user.token),
      ),
    );
    if (response.statusCode == 200) {
      ClientListResponse? data;
      try {
        data = ClientListResponse.fromJson(response.data);
      } catch (e) {
        data = null;
      }
      return AppResponseModel(
        code: 200,
        data: data ?? ClientListResponse(clientList: []),
      );
    } else {
      return AppResponseModel(code: response.statusCode ?? 500);
    }
  }
}
