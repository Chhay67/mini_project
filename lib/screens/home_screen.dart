import 'package:flutter/material.dart';
import 'package:mini_project/models/fetch_beer_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'beer_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int apiID = 0;
  late int productId = 0;
  //fetch api
  Future<dynamic> getBeerData() async {
    try {
      var beerData = await BeerData().fetchBeerData('');
      return beerData;
    } catch (e) {
      print(e);
    }
  }

  Future<void> setProductId(apiID) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('productId', apiID);
  }

  Future<void> getProductId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    productId = pref.getInt('productId')!;
  }

  @override
  void initState() {
    super.initState();
    getProductId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              setProductId(apiID);
            },
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  getProductId();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BeerDetailScreen(apiID: productId)),
                  );
                });
              },
              icon: const Icon(
                Icons.android_outlined,
                color: Colors.greenAccent,
              ))
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: getBeerData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var beer = snapshot.data;
            if (beer == null) {
              return const Text('Problem with request api');
            } else {
              return ListView.separated(
                itemCount: beer.length,
                itemBuilder: (context, i) => Container(
                  height: 70,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      border: Border.all(width: 0.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(4, 5),
                        )
                      ]),
                  child: ListTile(
                    leading: Image.network(
                      '${beer[i].image_url}',
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : const CircularProgressIndicator(); // progress mean waiting download image from network
                      },
                    ),
                    title: Text('${beer[i].name}'),
                    subtitle: Text(
                      '${beer[i].description}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        setProductId(apiID);
                      },
                    ),
                    onTap: () {
                      apiID = beer[i].id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BeerDetailScreen(apiID: apiID)),
                      );
                    },
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  thickness: 3,
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
