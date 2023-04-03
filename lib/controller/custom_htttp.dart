import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_model.dart';
class CustomHttpRequest{


  static Future<NewsModel> fetchHomeData(int pageNo,String sortBy) async{
    String category = "football";
    NewsModel? newsModel;
    try{
      String url = "https://newsapi.org/v2/everything?q=$category&sortBy=$sortBy&pageSize=10&page=$pageNo&apiKey=bc690759768242818430544757abf106";
      var response = await http.get(Uri.parse(url));
      var decodeData = jsonDecode(response.body);
      newsModel = NewsModel.fromJson(decodeData);
      return newsModel!;
    }catch(e){
      print("Something is wrong $e");
      return newsModel!;
    }
  }

   static fetchHomeDataToList(String sortBy,int pageNo) async {

    List<NewsModel> myList = [];
    String url = "https://newsapi.org/v2/everything?q=football&sortBy=$sortBy&pageSize=10&page=$pageNo&apiKey=bc690759768242818430544757abf106";
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    for(var i in data){
      myList.add(i);
    }
    return myList;
  }


  static Future<NewsModel> fetchSearchData(String query) async{
    NewsModel? newsModel;
    try{
      String url = "https://newsapi.org/v2/everything?q=$query&pageSize=20&apiKey=bc690759768242818430544757abf106";
      var response = await http.get(Uri.parse(url));
      var decodeData = jsonDecode(response.body);
      print("our responce is ${decodeData}");
      newsModel = NewsModel.fromJson(decodeData);
      return newsModel!;
    }catch(e){
      print("Something is wrong $e");
      return newsModel!;
    }
  }

}