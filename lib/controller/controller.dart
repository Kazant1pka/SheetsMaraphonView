// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:maraphons/model/form.dart';

class FormController {
  FormController({required this.url});

  final String url;

  Stream<List<FeedbackForm>> getStreamList() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield await http.get(Uri.parse(url)).then((value) {
        var jsonFeedback = convert.jsonDecode(value.body) as List;
        return jsonFeedback.map((e) => FeedbackForm.fromJson(e)).toList();
      });
    }
  }

  Future<List<FeedbackForm>> getList() async {
    return await http.get(Uri.parse(url)).then((value) {
      var jsonFeedback = convert.jsonDecode(value.body) as List;
      return jsonFeedback.map((e) => FeedbackForm.fromJson(e)).toList();
    });
  }
}
