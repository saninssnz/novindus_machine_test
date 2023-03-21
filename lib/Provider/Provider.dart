import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:novindus_machine_test/Api/Api.dart';
import 'package:novindus_machine_test/Model/NewsCategoryDetailsModel.dart';
import 'package:novindus_machine_test/Model/NewsCategoryModel.dart';

class DataProvider with ChangeNotifier{

  List<NewsCategoryModel> newsCategoryList = [];
  List<NewsCategoryDetailsModel> newsCategoryDetailsList = [];

  bool isDataLoading = false;
  bool isCategoryLoading = false;

  Future<void> getCategories(BuildContext context) async {
    var response;

    isCategoryLoading = true;

    String url = Api.NEWS_AND_BLOGS;
    response = await http.get(Uri.parse(url));

    isCategoryLoading = false;

    if (response.statusCode == 202) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
      var resultData = data["blogs_category"];

      newsCategoryList = List<NewsCategoryModel>.from(
          resultData.map((x) => NewsCategoryModel.fromJson(x)));

      notifyListeners();
    }
  }

  Future<void> getCategoryData(BuildContext context, String val) async {
    var response;

    isDataLoading = true;

    String url = Api.NEWS_AND_BLOGS_CAT;

    var body = {
      'category': val,
    };


    response = await http.post(Uri.parse(url),body: body);

    isDataLoading = false;

    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
      var resultData = data["results"];

      newsCategoryDetailsList = List<NewsCategoryDetailsModel>.from(
          resultData.map((x) => NewsCategoryDetailsModel.fromJson(x)));

      notifyListeners();
    }
  }
}