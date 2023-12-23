import 'package:flutter/foundation.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;

Future<bool> savePdfFile(String url, String fileName) async {
  final data = await http.get(Uri.parse(url));
  try {
    if (data.statusCode == 200) {
      final params = SaveFileDialogParams(
        data: data.bodyBytes,
        fileName: '$fileName.pdf',
      );
      final savedFiledPath = await FlutterFileDialog.saveFile(params: params);
      if (savedFiledPath == null) {
        throw Exception('Failed to download pdf');
      }
    } else {
      throw Exception("Error while downloading file");
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
  return true;
}
