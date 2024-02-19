import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';

const availableCategories = [
  Category(
      id: "9", title: 'General Knowledge', icon: Icons.south_america_rounded),
  Category(id: "11", title: 'Film', icon: Icons.movie_creation_rounded),
  Category(id: "12", title: 'Music', icon: Icons.music_note_rounded),
  Category(id: "30", title: 'Gadgets', icon: Icons.phone_android),
  Category(id: "31", title: 'Anime & Manga', icon: Icons.animation_rounded),
  Category(id: "28", title: 'Vehicles', icon: Icons.directions_bike_rounded),
  Category(id: "22", title: 'Geography', icon: Icons.location_on_rounded),
  Category(id: "21", title: 'Sports', icon: Icons.sports_baseball_rounded),
  Category(id: "23", title: 'History', icon: Icons.history_edu_rounded),
  Category(id: "any", title: 'Any Category', icon: Icons.quiz_rounded),
];
