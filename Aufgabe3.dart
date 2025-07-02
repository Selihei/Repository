
abstract class DatabaseRepository{
//Game Methoden//
//Empfängt alle Spiele
Future<List<Game>> getGames();
//Bekomme alle Daten zu einem Game
Future<Game> getGame();
//Aktualisiert den Game Datensatz durch Status
Future<void> updateGame(String name, String status);
//Auswahl Game
Future<List<Game>> getGameRCM(Future<List<Game>> ownGames, Future<List<String>> gameTags );

//Media Methoden//
//Empfängt alle Medien
Future<List<Media>> getMedias();
//Bekomme alle Daten zu einem Medium
Future<Media> getMedia();
//Aktualisiert den Media Datensatz durch Status
Future<void> updateMedia(String name, String status);
//Auswahl Media
Future<List<Media>> getMediaRCM(Future<List<Media>> ownMedia, Future<List<String>> mediaTags );

//Allgemein Stuff
//Auswahl Funktion
Future<void> selectionRCM(
  int choice,
  List<Game> ownGames,
  List<String> gameTags,
  List<Media> ownMedias,
  List<String> mediaTags,
) ;

//Bekomme Profil
Future<Profile> getProfile();
}

//
//Oberklasse Objekt kann man noch einfügen um einer Vererbung von Game und Media zu machen
//

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
    int mtype; // 1 Film, 2 Serie, 3 Anime
    String mStatus;
    final String mdescription;
    final List<String> mtags;
    String? mnotes;

    Media({required this.mname, required this.mtype, required this.mStatus, required this.mdescription, required this.mtags,this.mnotes});
}

class Profile{
    String pname;
    String pmail;
    DateTime birthday;

    Profile(this.pname,  this.pmail, this.birthday);
}

class MockDatabaseRepository implements DatabaseRepository{

//Allgemein Implentierungen

//Nur ein Profil bekommen
@override
Future<Profile> getProfile() async{
    return Profile("Rainer Zufall","RainerZufall@gmail", DateTime.now());
}

//Auswahl Funktion
@override
Future<void> selectionRCM(
  int choice,
  List<Game> ownGames,
  List<String> gameTags,
  List<Media> ownMedias,
  List<String> mediaTags,
) async {
  if (choice == 1) {
    await getGameRCM(Future.value(ownGames), Future.value(gameTags));
  } else if (choice == 2) {
    await getMediaRCM(Future.value(ownMedias), Future.value(mediaTags));
  }
  //Möglichkeit zur Erweiterung
}


//Game Implementierungen
//Dummy Listen
//Alle Spiele
final List<Game> games = [Game(gname: "Game B", gStatus: "not interested", gdescription: "FPS Shooter", gtags: ["Shooter","Horror"]),
Game(gname: "Game C", gStatus: "interested", gdescription: "COD Ableger", gtags: ["Shooter", "Open World"])];
//Nur eigene Spiele 
List<Game> ownGames = [Game(gname: "Game F", gStatus: "interested", gdescription: "FPS Shooter", gtags: ["Shooter","Horror"]),
Game(gname: "Game H", gStatus: "interested", gdescription: "COD Ableger", gtags: ["Shooter", "Open World"])];

//Alle Spiele bekommen
@override
Future<List<Game>> getGames() async{
    return games;
}

//Nur ein Spiel bekommen
@override
Future<Game> getGame() async{
    return Game(gname: "Game A", gStatus: "finished", gdescription: "Spieler ist ein Cowboy", gtags: ["Adventure", "Open World"]);
}

//Ein Spiel Status updaten
@override
Future<void> updateGame(String name, String status) async {
    for( Game game in games){
        if( game.gname == name){
            game.gStatus = status;
            return;
        }
    }
    }

//Spiele vorgeschlagen bekommen anhand von Gametags
@override
Future<List<Game>> getGameRCM(Future<List<Game>> ownGames, Future<List<String>> gameTags) async {
List<Game> ownedGameNames = await ownGames;
 List<String> tags = await gameTags;

  // Nur Spiele aus der eigenen Liste holen
  final List<Game> ownedGames = games.where((g) => ownedGameNames.contains(g.gname)).toList();

  List<Game> matchedGames = [];

  for (Game game in ownedGames) {
    // Prüfen, ob eines der Tags übereinstimmt
    if (game.gtags.any((tag) => tags.contains(tag))) {
      matchedGames.add(game);
      if (matchedGames.length >= 5) break; // max. 5
    }
  }
  return matchedGames;
}

//Media Implementierungen
//Dummy Listen
//Alle Medien
final List<Media> medias = [Media(mname: "Series 2", mtype: 2, mStatus: "interested", mdescription: "not interested", mtags: ["Comedy", "Action"]),
Media(mname: "Anime 3", mtype: 3, mStatus: "not interested", mdescription: "Junge sieht Geister", mtags: ["Horror"])];
//Eigene Medien
List<Media> ownMedias = [Media(mname: "Series 5", mtype: 2, mStatus: "interested", mdescription: "interested", mtags: ["Comedy", "Action"]),
Media(mname: "Anime 75", mtype: 3, mStatus: "interested", mdescription: "Junge sieht Geister", mtags: ["Horror"])];

//Bekomme alle Medien
@override
Future<List<Media>> getMedias() async{
    return medias; 
}

//Bekomme ein Medium
@override
Future<Media> getMedia() async{
    return Media(mname: "Movie 1",mtype: 1, mStatus: "finished", mdescription: "Typ verwandelt sich in eine Katze", mtags: ["Comendy", "Feel Good"]);
}

//Update ein Medium Status
@override
Future<void> updateMedia(String name, String status) async {
    for( Media media in medias){
        if( media.mname == name){
            media.mStatus = status;
            return;
        }
    }
    }

//Medien vorgeschlagen bekommen anhand von Mediatags
@override
Future<List<Media>> getMediaRCM(Future<List<Media>> ownMedias, Future<List<String>> mediaTags) async {
List<Media> ownedMediaNames = await ownMedias;
List<String> tags = await mediaTags;

  // Nur Medien aus der eigenen Liste holen
  final List<Media> ownedMedias = medias.where((m) => ownedMediaNames.contains(m.mname)).toList();

  List<Media> matchedMedias = [];

  for (Media media in ownedMedias) {
    // Prüfen, ob eines der Tags übereinstimmt
    if (media.mtags.any((tag) => tags.contains(tag))) {
      matchedMedias.add(media);
      if (matchedMedias.length >= 5) break; // max. 5
    }
  }
  return matchedMedias;
}
}