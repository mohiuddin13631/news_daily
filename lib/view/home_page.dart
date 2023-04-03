import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/controller/news_provider.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/view/news_details.dart';
import 'package:news_app/view/search_page.dart';
import 'package:news_app/widgets/my_theme.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String category = "football";
  int pageNo = 1;
  String sortBy = 'publishedAt';
  final scrollController = ScrollController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  // Future<void> share() async {
  //   await FlutterShare.share(
  //       title: 'Example share',
  //       text: 'Example share text',
  //       linkUrl: 'https://flutter.dev/',
  //       chooserTitle: 'Example Chooser Title'
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b192e),
      appBar: AppBar(
        backgroundColor: Color(0xff131221),
        title: Text("News app",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "CustomFont",color: Color(0xffb4b5b2)),),
        centerTitle: true,
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));
            },
              child: Image.asset("assets/images/search.png")
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){
                    if(pageNo > 1){
                      setState(() {
                        pageNo--;
                      });
                    }
                  }, child: Text("Prev")),
                  ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            pageNo = index+1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 10),
                          height: 45,
                          color: pageNo == index+1? Colors.red: Colors.blue,
                          child: Center(child: Text("${index + 1}")),
                        ),
                      );
                  },),

                  ElevatedButton(onPressed: (){
                    setState(() {
                      pageNo++;
                    });
                  }, child: Text("Next")),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton(
                style: TextStyle(color: Colors.white),

                dropdownColor: Color(0xff001429),
                value: sortBy,
                items: [
                  DropdownMenuItem(child: Text("publishedAt"),value: "publishedAt",),
                  DropdownMenuItem(child: Text("popularity"),value: "popularity",),
                  DropdownMenuItem(child: Text("relevancy"),value: "relevancy",),
              ], onChanged: (value) {
                  sortBy = value!;
                  setState(() {

                  });
              },),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: FutureBuilder<NewsModel>(
                  future: NewsProvider.getHomeData(pageNo,sortBy),builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.hasError){
                    return const Text("Something is wrong");
                  }
                  else if(snapshot.data == null){
                    return const Text("SnapShot data are null");
                  }
                  return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      var size = MediaQuery.of(context).size;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Stack(
                          children: [
                            Container(
                              height: (size.height / snapshot.data!.articles!.length)-30,
                              width: double.maxFinite,
                              color: Color(0xff001429),
                              child: Text(""),
                            ),
                            Positioned(left: 0,top: 0,child: Container(height: 50,width: 50,color: Color(0xffe94560),)),
                            Positioned(right: 0,bottom:0,child: Container(height: 50,width: 50,color: Color(0xffe94560),)),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                // height: (size.height / snapshot.data!.articles!.length)-30,
                                height: 150,
                                width: double.maxFinite,
                                color: Color(0xff001429),
                                // color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: double.maxFinite,
                                          width: double.maxFinite,

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child:InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(articles: snapshot.data!.articles![index]),));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16.0),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: "${snapshot.data!.articles![index].urlToImage}",
                                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.only(top: 10),
                                          // color: Colors.green,
                                          child: Column(
                                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("category", style: TextStyle(color: Color(0xffe2dfdd),fontSize: 16),maxLines: 1,),
                                                  Spacer(),
                                                  Text("${snapshot.data!.articles![index].source!.name}",style: myTextStyle(),)
                                                ],
                                              ),
                                              const SizedBox(height: 8,),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(articles: snapshot.data!.articles![index]),));
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("${snapshot.data!.articles![index].title}",style: myTextStyle(15,FontWeight.w400),maxLines: 1,),
                                                    const SizedBox(height: 8,),
                                                    Text("Author: ${snapshot.data!.articles![index].author}",textAlign: TextAlign.start, style: myTextStyle(),maxLines: 1,),
                                                  ],
                                                ),
                                              ),

                                              // SizedBox(height: 8,),
                                              Row(
                                                children: [
                                                  Icon(Icons.link,color: Color(0xffe2dfdd),),

                                                  Text("${Jiffy("${snapshot.data!.articles![index].publishedAt}").format('d/MMM/yyyy')}",style: myTextStyle(),),
                                                  Spacer(),
                                                  IconButton(onPressed: (){

                                                    Future<void> share() async {
                                                      await FlutterShare.share(
                                                          title: 'Example share',
                                                          text: 'Example share text',
                                                          linkUrl: snapshot.data!.articles![index].url,
                                                          chooserTitle: 'Example Chooser Title'
                                                      );
                                                    }
                                                    share();

                                                  }, icon: Icon(Icons.share,color: Colors.white,),)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },);
                },
                )
              ),
            ),
          ],
        ),
      )
    );
  }

  void _scrollListener() {

  }

}


