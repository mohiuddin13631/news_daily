import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/practice/random_model.dart';
import 'package:http/http.dart' as http;
class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {

  RandomModel? randomModel;
  Address? address;
  List<Address> addressList = [];
  List<RandomModel> myList = [];
  loadApiData() async {
    String url = "https://random-data-api.com/api/v2/users?size=2&is_xml=true";
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    for(var i in data){
      randomModel = RandomModel.fromJson(i);
      setState(() {
        myList.add(randomModel!);
      });
    }
    var j = 0;
    for(var k in data[j]['address']){ //todo: problem
      address = Address.fromJson(k);
      setState(() {
        addressList.add(address!);
        j++;
      });
    }
    print(myList.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadApiData();
    print(addressList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: myList.length,
          // itemCount: addressList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text("${myList[index].address!.coordinates!.lat}"),
                // Text("${addressList[index].city}"),
              ],
            );

        },)
      ),
    );
  }
}
