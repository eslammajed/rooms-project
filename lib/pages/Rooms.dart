import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/pages/homepage.dart';
import '../controllers/database_cntrollers.dart';
import '../Processes/Add_product.dart';
import '../components/listitme.dart';
import '../modles/itme.dart';
import 'page.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  DBHElper dbhElper = DBHElper();
  int? currentPosition;
  List<itme> rooms = [];

  @override
  void initState() {
    super.initState();
    dbhElper.ShowDataTable().then((result) {
      if (result.isNotEmpty) {
        rooms = result;
        setState(() {});
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 144, 175),
        title: const Center(
          child: Text(
            'الغرف',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'El Messiri',
              fontSize: 25,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(
              builder: (context) => Home_Page(),
            ));
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return listitme(
                  Itme: rooms[index],
                  ontap: () {
                    currentPosition = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cropinformation(
                          Markets: rooms[currentPosition!],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => homeadd(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
