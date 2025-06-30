
abstract class DatabaseRepository{
//Game Methoden//
//Empfängt alle Spiele
Future<List<String>> getGames();
//Aktualisiert den Game Datensatz durch Status
Future<void> updateGame(String name, String status);
//Auswahl Game
Future<List<String>> getGameRCM(int choice, Future<List<String>> getGames, Future<List<String>> GameTags );



//Media Methoden//
//Empfängt alle Medien
Future<List<String>> getMedia();
//Aktualisiert den Media Datensatz durch Status
Future<void> updateMedia(String name, String status);
//Auswahl Media
Future<List<String>> getMediaRCM(int choice, Future<List<String>> getMedia, Future<List<String>> MediaTags );


}