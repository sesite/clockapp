import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'euro.jpg'),
    WorldTime(
        url: 'Asia/Novosibirsk', location: 'Новосибирск', flag: 'russian.jpg'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'euro.jpg'),
    WorldTime(
        url: 'Asia/Novokuznetsk', location: 'Киселевск', flag: 'russian.jpg'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.jpg'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'asia.jpg'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build ChooseLocation');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Выбор местоположения'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(locations[index].location),
                onTap: () {
                  updateTime(index);
                },
                leading: Container(
                  width: 60,
                  child: Image.asset('assets/images/${locations[index].flag}'),
                ),
              ),
            );
          }),
    );
  }
}
