import 'package:flutter/material.dart';
import 'package:pawpal_pet_adoption/models/user.dart';
import 'package:pawpal_pet_adoption/shared/mydrawer.dart';

class PetScreen extends StatefulWidget {
  final User? user;

  const PetScreen({super.key, this.user});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Pet Adoption Page')),
      body: Center(child: Text('My Pet Adoption Page')),
      drawer: MyDrawer(user: widget.user),
    );
  }
}