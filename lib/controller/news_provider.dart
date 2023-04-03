
import 'package:flutter/cupertino.dart';
import 'package:news_app/controller/custom_htttp.dart';
import 'package:news_app/model/news_model.dart';

class NewsProvider with ChangeNotifier{

  static Future<NewsModel> getHomeData(int pageNo, String sortBy) async {
    NewsModel? newsModel;
    newsModel = await CustomHttpRequest.fetchHomeData(pageNo,sortBy);
    return newsModel!;
  }

  static Future<List<NewsModel>?> getHomeDataList(String sortBy, int pageNo) async {
    List<NewsModel>? myList;
    myList = await CustomHttpRequest.fetchHomeDataToList(sortBy, pageNo);
    return myList;
  }
}