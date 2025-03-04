import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../data/database_cntrollers.dart';
import 'add_room_screen.dart';
import '../components/listitme.dart';
import '../models/room.dart';
import 'room_info_screen.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  DBHelper dbhElper = DBHelper();
  int? currentPosition;
  List<Room> rooms = [];

  @override
  void initState() {
    super.initState();
    dbhElper.getRooms().then((result) {
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
                  room: rooms[index],
                  ontap: () {
                    currentPosition = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomInfoScreen(
                          room: rooms[currentPosition!],
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
                      builder: (context) => AddRoom(),
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
