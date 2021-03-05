import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Doctor.dart';
import 'package:ninja_trips/screens/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  List<Widget> _doctorTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addDoctors();
    print('Heeeeeeeeeeeeere : ${_doctorTiles}');
  }

  Future<void> _addDoctors() async {
    QuerySnapshot doctor =
        await FirebaseFirestore.instance.collection('doctors').get();
    doctor.docs.map((doc) {
      Doctor currentDoctor = Doctor.fromJSON(doc.data());
      _doctorTiles.add(_buildTile(currentDoctor));
    }).toList();
  }

  Widget _buildTile(Doctor doctor) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(doctor: doctor)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('prix de la consultation : ${doctor.price} €',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text('specialité : ${doctor.specialty}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),

          Text(doctor.title(), style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'location-img-${doctor.img}',
          child: Image.asset(
            'images/${doctor.img}',
            height: 50.0,
          ),
        ),
      ),
      trailing: Text('${doctor.location}'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _doctorTiles.length,
        itemBuilder: (context, index) {
          return _doctorTiles[index];
        });
  }
}
