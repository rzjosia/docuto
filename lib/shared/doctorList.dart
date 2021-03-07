import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Doctor.dart';
import 'package:ninja_trips/screens/details.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addDoctors();
  }

  Future<List<Widget>> _addDoctors() async {
    QuerySnapshot doctor = await FirebaseFirestore.instance
        .collection('doctors')
        .orderBy('price', descending: true)
        .get();

    return doctor.docs.map((doc) {
      print('Here db : ${doc.data()['surname']}');
      Doctor currentDoctor = Doctor.fromJSON(doc.data());
      currentDoctor.id = doc.id;
      print(currentDoctor.id);
      return _buildTile(currentDoctor);
    }).toList();
  }

  Widget _buildTile(Doctor doctor) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Details(doctor: doctor)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('prix de la consultation : ${doctor.price} €',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text('specialité : ${doctor.specialty}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text(doctor.title(),
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
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
    return FutureBuilder(
      future: _addDoctors(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              key: _listKey,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return snapshot.data[index];
              });
        }

        if (snapshot.hasError) {
          print('Error chargement firebase : ${snapshot.error}');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    child: Text(
                        "Oops ! Une erreur s'est produite. La liste des docteurs n'a pas pu être chargé.")),
              ],
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            ],
          ),
        );
      },
    );
  }
}
