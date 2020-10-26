import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  //* Симуляция запроса данных из API/BD (асинхронно)
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime; // день или ночь ?

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //* Симуляция запроса данных из API/BD (асинхронно)
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      time = DateFormat.Hm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20;
    } catch (e) {
      print('Error url: $e');
      time = 'Не смог получить время';
    }
  }
}
