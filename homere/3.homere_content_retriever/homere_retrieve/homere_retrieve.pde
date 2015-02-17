import org.jsoup.safety.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import org.jsoup.nodes.*;

JSONObject output;
void setup() {

  output = new JSONObject();
  JSONObject meta = loadJSONObject("homere_refined_index.json").getJSONObject("meta");
  output.setJSONObject("meta", meta);

  JSONArray chantsOut = new JSONArray();

  JSONArray chants = loadJSONObject("homere_refined_index.json").getJSONArray("content");

  for (int i = 0; i < chants.size (); i++) {
    JSONObject partie = chants.getJSONObject(i);
    partie.setString("title", partie.getString("title").replaceAll("’", "'").replaceAll("\u2014","-"));
    JSONArray poemes = parsePoeme(partie.getString("link"));
    partie.setJSONArray("contents", poemes);    
    chantsOut.append(partie);
  }

  output.setJSONArray("content", chantsOut);
  println("ok for saving");
  saveJSONObject(output, "output/homere_data.json");
  print("done saving");

  exit();
}

JSONArray parsePoeme(String url) {
  JSONArray poemes = new JSONArray();

  try {
    Document doc = Jsoup.connect(url).get(); 
    println("parsing "+url);
    Element myin = doc.getElementById("mw-content-text");
    Elements els = myin.getElementsByClass("poem");


    String raw = "";
    for (int i = 0; i < els.size (); i++) {
      Elements children = els.get(i).children();
      for (Element e : children) {
        raw += e.html().toString();
      }
    }
    String[] lignes = raw.split("<br>");
    for (String p : lignes) {
      //todo
      /*p = "<div>" + p + "</div>";
      Document docT = Jsoup.parse(p);
      p = doc.text();
      println(p);*/
      p = trim(p.replace("&nbsp;", "")
        .replaceAll("’", "'")
        .replaceAll("\u2026", "...")
        .replaceAll("\u2014", "-")
        .replaceAll("<(.)*>", ""));
      poemes.append(p);
    }
    if (poemes.getString(0).equals(""))poemes.remove(0);
  }
  catch(IOException e) {
    println("erreur de chargement");
  }

  return poemes;
}

