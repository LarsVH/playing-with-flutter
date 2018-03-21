import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'places.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Restos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Place> _places = <Place>[];
  Map<String,double> _ourPlace;

  @override
  initState() {
    super.initState();
    dolocationstuff();
  }

  dolocationstuff() async {
    await listenForLocation();  // Retrieve current coordinates
    await listenForPlaces();
  }

  listenForLocation() async {
    _ourPlace = await getCurrentLocation();
    print(_ourPlace.values);
    print(_ourPlace["latitude"]);
    _ourPlace["latitude"] = 47.3667;
    _ourPlace["logitude"] = 8.5500;
  }

  listenForPlaces() async {
    var stream = await getPlaces(_ourPlace["latitude"], _ourPlace["longitude"], 'restaurant');
    stream.listen((place) =>
    setState( () => _places.add(place))    
    );
    print("placeslength" + _places.length.toString());
  }


  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      appBar: new AppBar(       
        title: new Text(widget.title),
      ),
      body: new Center(        
        child: new ListView(
          children: _places.map((place) => new Text(place.name)).toList(),
        )



       // child: new Text(_ourPlace["latitude"].toString() + " " + _ourPlace["longitude"].toString())

    ),
  );
  }
}
