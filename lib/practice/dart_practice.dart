void main(){
  var myList = [
    {
      "address": {
        "city": "Montyfort",
        "street_name": "Fritsch Locks",
        "street_address": "1550 Smitham Fall",
        "zip_code": "56733-8841",
        "state": "Wisconsin",
        "country": "United States",
        "coordinates": {
          "lat": -31.122866289626565,
          "lng": 116.07133397556277
        }
      },
      "credit_card": {
        "cc_number": "5589-8660-0092-9838"
      },
      "subscription": {
        "plan": "Starter",
        "status": "Pending",
        "payment_method": "WeChat Pay",
        "term": "Monthly"
      }
    },
    {
      "address": {
        "city": "East Trenaburgh",
        "street_name": "Kimber Estate",
        "street_address": "24914 Thaddeus Way",
        "zip_code": "30164-6717",
        "state": "Connecticut",
        "country": "United States",
        "coordinates": {
          "lat": 8.32923900945896,
          "lng": 8.667183576966977
        }
      },
      "credit_card": {
        "cc_number": "4624506953697"
      },
      "subscription": {
        "plan": "Premium",
        "status": "Active",
        "payment_method": "Bitcoins",
        "term": "Annual"
      }
    }
  ];
  List newList = [];
  // for(var i in myList){
  //   newList.add(i);
  // }
  for(int i = 0; i<myList.length; i++){
    print("--------------------");
    newList.add(myList[i]['address']);
  }
  // print(myList[0]['address']!['country']);
  print(newList);
}
