
import 'package:flutter/material.dart';
import 'package:malhar_2023/flappy.dart';
import 'package:malhar_2023/models/date_model.dart';
import 'package:malhar_2023/models/event_type_model.dart';
import 'package:malhar_2023/models/events_model.dart';
import 'package:malhar_2023/pages/blog.dart';
import 'package:malhar_2023/pages/contact.dart';

List<DateModel> getDates(){

  List<DateModel> dates = [];
  DateModel dateModel = DateModel();

  //1
  dateModel.date = "10";
  dateModel.weekDay = "Sun";
  dates.add(dateModel);

  dateModel = DateModel();

  //1
  dateModel.date = "11";
  dateModel.weekDay = "Mon";
  dates.add(dateModel);

  dateModel = DateModel();


  //1
  dateModel.date = "12";
  dateModel.weekDay = "Tue";
  dates.add(dateModel);

  dateModel = DateModel();

  //1
  dateModel.date = "13";
  dateModel.weekDay = "Wed";
  dates.add(dateModel);

  dateModel = DateModel();


  //1
  dateModel.date = "14";
  dateModel.weekDay = "Thu";
  dates.add(dateModel);

  dateModel = DateModel();


  //1
  dateModel.date = "15";
  dateModel.weekDay = "Fri";
  dates.add(dateModel);

  dateModel = DateModel();


  //1
  dateModel.date = "16";
  dateModel.weekDay = "Sat";
  dates.add(dateModel);

  dateModel = DateModel();

  return dates;

}

List<EventTypeModel> getEventTypes(){

  List<EventTypeModel> events = [];
  EventTypeModel eventModel = EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/concert.png";
  eventModel.eventType = "Blog";
  eventModel.page = const Blog();
  eventModel.icon = const Icon(Icons.web);
  events.add(eventModel);

  eventModel = EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/sports.png";
  eventModel.eventType = "Games";
  eventModel.page = const FlappyWindow();
  eventModel.icon = const Icon(Icons.videogame_asset_rounded);
  events.add(eventModel);

  eventModel = EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/education.png";
  eventModel.eventType = "Contact";
  eventModel.page = const Contact();
  eventModel.icon = const Icon(Icons.people);
  events.add(eventModel);

  eventModel = EventTypeModel();

  return events;
}

List<EventsModel> getEvents(){

  List<EventsModel> events = [];
  EventsModel eventsModel = EventsModel();

  //1
  eventsModel.imgeAssetPath = "assets/tileimg.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.desc = "Sports Meet in Galaxy Field";
  eventsModel.address = "Greenfields, Sector 42, Faridabad";
  events.add(eventsModel);

  eventsModel = EventsModel();

  //2
  eventsModel.imgeAssetPath = "assets/second.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.desc = "Art & Meet in Street Plaza";
      eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
  events.add(eventsModel);

  eventsModel = EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/music_event.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/music_event.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/music_event.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = EventsModel();



  return events;


}