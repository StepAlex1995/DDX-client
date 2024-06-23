import 'package:image_picker/image_picker.dart';

class SendMsgVoiceRequest {
  final int taskId;
  final int trainerId;
  final int clientId;
  final XFile file;
  final int date;
  final bool isSendClient;

  SendMsgVoiceRequest({required this.taskId, required this.trainerId, required this.clientId, required this.file, required this.date, required this.isSendClient});


  @override
  String toString() {
    return 'SendMsgVoiceRequest{taskId: $taskId, trainerId: $trainerId, clientId: $clientId, file: $file, date: $date, isSendClient: $isSendClient}';
  }
}
