import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/models/fetch_beer_data.dart';

class BeerDetailScreen extends StatelessWidget {
  final int apiID;
  const BeerDetailScreen({Key? key, required this.apiID}) : super(key: key);
  Future<dynamic> getBeerData() async {
    try {
      var beerData = await BeerData().fetchBeerData(apiID.toString());
      return beerData;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: FutureBuilder<dynamic>(
          future: getBeerData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var beer = snapshot.data;
              if (beer == null) {
                return const Text('Problem with request api');
              } else {
                return Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(4, 5),
                                )
                              ]),
                          child: Image.network('${beer[0].image_url}'),
                        )),
                    const Divider(
                      thickness: 3,
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(4, 5),
                                )
                              ]),
                          child: Column(

                            children: [
                              Row(
                                children: const [
                                  Expanded(
                                      child: Text(
                                    'Title:',
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'Price:',
                                    style: TextStyle(fontSize: 10),
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 2.0),
                                      padding: const EdgeInsets.all(8.0),
                                      height: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white,
                                          border: Border.all(width: 0.2),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 3,
                                              offset: Offset(4, 5),
                                            )
                                          ]),
                                      child: Text('${beer[0].name}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 2.0, ),
                                    height: 100,
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white,
                                        border: Border.all(width: 0.2),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            offset: Offset(4, 5),
                                          )
                                        ]),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: '${beer[0].price} ',
                                            style: const TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: 'USD',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ]),
                                    ),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        )),
                    const Divider(
                      thickness: 3,
                    ),
                    Expanded(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 8.0,bottom: 5.0),
                          padding: const EdgeInsets.only(left: 8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(4, 5),
                                )
                              ]),
                          child: ListView(
                            children: [
                              Text('Description:',style: const TextStyle(fontSize: 10),),
                              Container(
                                margin: const EdgeInsets.only( right: 5.0,bottom: 5.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(width: 0.2),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(4, 5),
                                      )
                                    ]
                                ),
                                child: Text(
                                  'Description:${beer[0].description}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              ],

                          ),
                        )),
                  ],
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
