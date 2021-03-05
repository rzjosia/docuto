import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Trip.dart';
import 'package:ninja_trips/screens/details.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Widget> _tripTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addTrips();
  }

  void _addTrips() {
    // get data from db
    List<Trip> _trips = [
      Trip(
          title: 'Docteur Roch Faubert',
          location: 'Lille',
          price: '50',
          img: 'doctor1.png',
          address: '62  Chemin Challet',
          number: '03.53.04.96.63',
          specialty: 'Généraliste'),
      Trip(
          title: 'Docteur Jay Covillon',
          location: 'Tourcoing',
          price: '40',
          img: 'doctor2.png',
          address: '83  quai Saint-Nicolas',
          number: '03.20.28.13.31',
          specialty: 'Dermatologue'),
      Trip(
          title: 'Docteur Daisi Therrien',
          location: 'Roubaix',
          price: '35',
          img: 'doctor3.png',
          address: '51 rue de la Bruyère',
          number: '03.20.10.82.54',
          specialty: 'Cardiologue'),
      Trip(
          title: 'Docteur Albertine Kingui',
          location: 'Lens',
          price: '25',
          img: 'doctor4.png',
          address: '65  rue du Général Ailleret',
          number: '03.30.72.73.28',
          specialty: 'Gastro-Entérologue'),
    ];

    _trips.forEach((Trip trip) {
      _tripTiles.add(_buildTile(trip));
    });
  }

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(trip: trip)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('prix de la consultation : ${trip.price} €',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text('specialité : ${trip.specialty}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text(trip.title, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'location-img-${trip.img}',
          child: Image.asset(
            'images/${trip.img}',
            height: 50.0,
          ),
        ),
      ),
      trailing: Text('${trip.location}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _tripTiles.length,
        itemBuilder: (context, index) {
          return _tripTiles[index];
        });
  }
}
