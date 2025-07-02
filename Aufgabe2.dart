
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
//Oberklasse Objekt noch einfügen

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