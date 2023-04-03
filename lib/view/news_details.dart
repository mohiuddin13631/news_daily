import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view/news_web_view.dart';
import 'package:news_app/widgets/my_theme.dart';
class NewsDetails extends StatelessWidget {
  Articles articles;
  NewsDetails({required this.articles});

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: articles.url,
        chooserTitle: 'Example Chooser Title'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("${articles.source!.name}"),
        centerTitle: true,
        leading: Icon(Icons.arrow_back,color: Colors.white,),
        actions: [
          IconButton(onPressed: (){
            share();
          }, icon: Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("${articles.title}",style: myTextStyle(18,FontWeight.bold,Colors.white),),
            SizedBox(height: 11,),
            Text("${Jiffy("${articles!.publishedAt}").format('d/MMM/yyyy , on h:mm')}",style: myTextStyle(14),),
            SizedBox(height: 10,),
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "${articles!.urlToImage}",
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
            ),
            SizedBox(height: 11,),
            Text("Description",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            Text(articles.description.toString(),style: myTextStyle()),
            SizedBox(height: 11,),
            Text("Content",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            Text(articles.content.toString(),style: myTextStyle(),),
            SizedBox(height: 11,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsWebView(articles: articles),));
              },
              child: Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color(0xffe2dfdd).withOpacity(.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]
                ),
                child: Center(child: Text("Read more",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
