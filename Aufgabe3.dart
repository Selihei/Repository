
abstract class DatabaseRepository{
//Game Methoden//
//Empfängt alle Spiele
Future<List<Game>> getGames();
//Bekomme alle Daten zu einem Game
Future<Game> getGame();
//Aktualisiert den Game Datensatz durch Status
Future<void> updateGame(String name, String status);
//Auswahl Game
Future<List<String>> getGameRCM(int choice, Future<List<String>> getGames, Future<List<String>> GameTags );

//Media Methoden//
//Empfängt alle Medien
Future<List<Media>> getMedias();
//Bekomme alle Daten zu einem Medium
Future<Media> getMedia();
//Aktualisiert den Media Datensatz durch Status
Future<void> updateMedia(String name, String status);
//Auswahl Media
Future<List<String>> getMediaRCM(int choice, Future<List<String>> getMedia, Future<List<String>> MediaTags );

//Allgemein Stuff
//Bekomme Profil
Future<void> getProfile();
}

class Game {
    final String gname;
    String gStatus;
    final String gdescription;
    final List<String> gtags;
    String? gnotes;

    Game({required this.gname, required this.gStatus, required this.gdescription, required this.gtags,this.gnotes});
}

class Media {
    final String mname;
    String mStatus;
    final String mdescription;
    final List<String> mtags;
    String? mnotes;

    Media({required this.mname, required this.mStatus, required this.mdescription, required this.mtags,this.mnotes});
}


class MockDatabaseRepository implements DatabaseRepository{

final List<Game> games = [Game(gname: "Game B", gStatus: "not interested", gdescription: "FPS Shooter", gtags: ["Shooter","Horror"]),
Game(gname: "Game C", gStatus: "interested", gdescription: "COD Ableger", gtags: ["Shooter", "Open World"])];

@override
Future<List<Game>> getGames() async{
    return games;
}
@override
Future<Game> getGame() async{
    return Game(gname: "Game A", gStatus: "finished", gdescription: "Spieler ist ein Cowboy", gtags: ["Adventure", "Open World"]);
}















final List<String> medias = ["Movie 1", "Series 2", "Anime 3"];
final Map<String,String> mediaStatus = {"Movie 1" : "finished", "Series 2" : "interested", "Anime 3":"not interested"};

@override
Future<List<String>> getMedias() async{
    return medias; // nochanpasseb
}
@override
Future<String> getMedia() async{
    return "Movie 1";
}

}