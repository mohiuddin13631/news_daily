import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/controller/custom_htttp.dart';
import 'package:news_app/model/news_model.dart';

import '../widgets/my_theme.dart';
import 'news_details.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchController = TextEditingController();
  NewsModel? newsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onEditingComplete: () async {
                    newsModel = await CustomHttpRequest.fetchSearchData(searchController.text);
                    print(newsModel!.articles!.length);
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    prefixIcon: Icon(Icons.search,),
                    suffixIcon: InkWell(
                      onTap: () {
                        searchController.clear();
                        newsModel!.articles!.clear();
                        setState(() {

                        });
                      },
                        child: Icon(Icons.cancel_outlined)),
                  ),
                ),
              SizedBox(height: 19,),
            MasonryGridView.count(
              shrinkWrap: true,
              itemCount: keyword.length,
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    newsModel = await CustomHttpRequest.fetchSearchData(keyword[index]);
                    searchController.text = keyword[index];
                    setState(() {

                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(keyword[index]),
                    ),
                  ),
                );
              },
            ),
                newsModel?.articles == null? SizedBox(height: 0,): ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModel!.articles!.length,
                  itemBuilder: (context, index) {
                    var size = MediaQuery.of(context).size;
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(articles: newsModel!.articles![index]),));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Stack(
                          children: [
                            Container(
                              height: (size.height / newsModel!.articles!.length)-30,
                              width: double.maxFinite,
                              color: Color(0xff001429),
                              child: Text(""),
                            ),
                            Positioned(left: 0,top: 0,child: Container(height: 50,width: 50,color: Color(0xffe94560),)),
                            Positioned(right: 0,bottom:0,child: Container(height: 50,width: 50,color: Color(0xffe94560),)),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                // height: (size.height / newsModel!.articles!.length)-30,
                                height: 140,
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
                                          child:ClipRRect(
                                            borderRadius: BorderRadius.circular(16.0),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: "${newsModel!.articles![index].urlToImage}",
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
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
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("category",style: TextStyle(color: Color(0xffe2dfdd),fontSize: 16),),
                                                  Spacer(),
                                                  Text("${newsModel!.articles![index].source!.name}",style: myTextStyle(),)
                                                ],
                                              ),
                                              const SizedBox(height: 8,),
                                              Text("${newsModel!.articles![index].title}",style: myTextStyle(15,FontWeight.w400),maxLines: 1,),
                                              const SizedBox(height: 8,),
                                              Text("Author: ${newsModel!.articles![index].author}",style: myTextStyle(),maxLines: 1,),
                                              SizedBox(height: 8,),
                                              Row(
                                                children: [
                                                  Icon(Icons.link,color: Color(0xffe2dfdd),),
                                                  Spacer(),
                                                  Text("${Jiffy("${newsModel!.articles![index].publishedAt}").format('d/MMM/yyyy , on h:mm')}",style: myTextStyle(),),
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
                      ),
                    );
                  },)

              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> keyword = [
    "World",
    "Health",
    "Finance",
    "Bitcoin",
    "Football",
    "Cricket",
    "Sports",
    "Politics"];
}
