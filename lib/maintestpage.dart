import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MaintestPage extends StatelessWidget {
  final String apiUrl =
      "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all";

  final String apiUrl2 = "https://randomuser.me/api/?results=1";

  Future<List<dynamic>> fetchRec() async {
    var result = await http.get(Uri.parse(apiUrl));
    print(result);
    return json.decode(result.body)['data']['tournaments'];
  }

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl2));
    return json.decode(result.body)['results'];
  }

  String _name(dynamic game) {
    return game['name'];
  }

  String _gamename(dynamic game) {
    return game['game_name'];
  }


  String _username(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _userage(Map<dynamic, dynamic> user) {
    return user['dob']['age'].toString() + "56  elo";
  }

  Widget _backgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.6, 1.0],
          colors: [
            Color(0xffae9ddb),
            Color(0xff9284b8),
            Color(0xff4c3f6c),
          ],
        ),
      ),
    );
  }

  Widget _overview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color(0xff0d655d),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)),
              border: Border.fromBorderSide(BorderSide.none)),
          child: Column(
            children: [
              Text(
                '34',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'Tournaments',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'Played',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Container(
          width: 120,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color(0xff820c49),
              borderRadius: BorderRadius.circular(0),
              border: Border.fromBorderSide(BorderSide.none)),
          child: Column(
            children: [
              Text(
                '09',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'Tournaments',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'Won',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Container(
          width: 120,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color(0xaa621473),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
              border: Border.all(width: 0)),
          child: Column(
            children: [
              Text(
                '26%',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'Winning',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'Percentage',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }

  getRecommendations() {
    return FutureBuilder<List<dynamic>>(
      future: fetchRec(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index]['cover_url']),
                                      fit: BoxFit.fitWidth))),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                _name(snapshot.data[index]),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                _gamename(snapshot.data[index]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  getUserDetails() {
    return FutureBuilder<List<dynamic>>(
      future: fetchUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            alignment: Alignment.bottomLeft,
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 0, top: 5, left: 0, bottom: 3),
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(snapshot
                                      .data[index]['picture']['large'])),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, top: 15, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        _username(snapshot.data[index]),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              width: 2,
                                              color: Color(0xff0d655d),
                                            )),
                                        child: Center(
                                          child: Text(
                                            _userage(snapshot.data[index]),
                                            style: TextStyle(
                                                color: Color(0xff0d655d),
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 300,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xffae9ddb),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Flyingwolf',
                    style: TextStyle(color: Colors.white, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 010.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    ]),
                  ),
                ),
                getUserDetails(),
                SizedBox(
                  height: 10,
                ),
                _overview(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Recommended for you',
                  style: TextStyle(color: Colors.deepPurple, shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 12, 65, 85),
                    )
                  ]),
                ),
              ],
            ),
          )
        ],
        body: Stack(children: [
          _backgroundGradient(),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: getRecommendations()),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
