

class Env {
  String baseURL = "https://rwtest.pnj-dict.my.id";

  Uri getListWord() {
    return Uri.parse(baseURL + "/api/listword");
  }

  Uri getListWordLaw() {
    return Uri.parse(baseURL + "/api/listWordLaw");
  }
}
