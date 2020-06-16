import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'UI/Intray/intray_page.dart';
import 'models/global.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      //
      //         );
      //       },
      //     ); //unreachable data
      //   },
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiKey;
  @override
  Widget build(BuildContext context) {
    //bloc.registerUser("AkkuAk", "heroDK", "Akkuhero", "akkauheroDk@yahoo.in", "1234");
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          apiKey = snapshot.data;
        } else {
          print("NO API Token ");
        }
        // String apiKey = snapshot.data;
        // apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0 ? getHomePage() : LoginPage(login: login, newUser: false,);
      },
    );
  }

  void login(){
    setState(() {
      build(context);
    });
  }

  Future signinUser() async {
    apiKey = await getApiKey();
    if(apiKey != null){
      if(apiKey.length > 0){
        userBloc.signinUser("", "", apiKey);
      } else {
        print("No api key");
      }
    } else {
      apiKey = "";
    }
    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("API_TOKEN");
  }

  Widget getHomePage() {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(
              children: <Widget>[
                TabBarView(
                  children: [
                    IntrayPage(apiKey: apiKey,),
                    new Container(
                      color: Colors.orange,
                    ),
                    new Container(
                      color: Colors.lightGreen,
                      child: Center(
                        child: FlatButton(
                          color: redColor,
                          child: Text("LOG_OUT"),
                          onPressed: (){
                            logout();    
                          },
                          ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 50.0),
                  height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "InTray",
                        style: intrayTitleStyle,
                      ),
                      Container(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 130.0,
                      left: MediaQuery.of(context).size.width * 0.4),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      size: 40.0,
                    ),
                    backgroundColor: redColor,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: darkGreyColor,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_TOKEN", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();  
  }
}
