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
  JSONObject meta = loadJSONObject("stevenson_refined_index.json").getJSONObject("meta");
  String url = meta.getString("url");
  output.setJSONObject("meta", meta);

  JSONArray contentGlobalOut = new JSONArray();

  JSONArray chapitres = loadJSONObject("stevenson_refined_index.json").getJSONArray("content");
  JSONArray contentsOut = new JSONArray();
  try {
    Document doc = Jsoup.connect(url).get();
    Elements elements = doc.getElementsByClass("text").get(0).children();

    int count = 0;
    JSONObject currentChapter = chapitres.getJSONObject(count);
    JSONArray paragraphs = new JSONArray();

    //begin after first title h2
    for (int i = 1; i < elements.size (); i++) {
      Element e = elements.get(i);

      if (e.tag().toString().equals("p")) {
        String p = e.text().toString();
        p = (p.replace("&nbsp;", "")
          .replaceAll("\u2013", "-")
          .replaceAll("’", "'")
          .replaceAll("\u2026", "...")
          .replaceAll("\u2014", "-")
          .replaceAll("<(.)*>", ""));
        paragraphs.append(p);
      } else if (e.tag().toString().equals("h2")) {
        //save past current chapter
        currentChapter.setString("title", currentChapter.getString("title").replaceAll("\u2019", "'"));
        currentChapter.setJSONArray("paragraphs", paragraphs);
        contentsOut.append(currentChapter);
        //reset and update current chapter
        count++;
        currentChapter = chapitres.getJSONObject(count);
        paragraphs = new JSONArray();
      } else {
        println(e.tag());
      }

      //case of last chapter
      if (i == elements.size()-1) {
        currentChapter.setString("title", currentChapter.getString("title").replaceAll("\u2019", "'"));
        currentChapter.setJSONArray("paragraphs", paragraphs);
        contentsOut.append(currentChapter);
      }

      /*println(e.tag());
       println(e.html());*/
    }
  }
  catch(IOException e) {
    println(e);
  }


  output.setJSONArray("content", contentsOut);
  println("ok for saving");
  saveJSONObject(output, "output/stevenson_data.json");
  println("done saving");

  exit();
}

/*JSONArray parsePoeme(String url){
 JSONArray poemes = new JSONArray();
 
 try {
 Document doc = Jsoup.connect(url).get(); 
 println("parsing "+url);
 Element myin = doc.getElementById("mw-content-text");
 Elements els = myin.getElementsByClass("poem");
 
 
 String raw = "";
 for(int i = 0 ; i < els.size() ; i++){
 Elements children = els.get(i).children();
 for(Element e : children){
 raw += e.html().toString();
 
 }
 
 }
 String[] lignes = raw.split("<br>");
 for(String p : lignes){
 p = trim(p.replace("&nbsp;", "")
 .replaceAll("’", "'")
 .replaceAll("\u2026", "...")
 .replaceAll("\u2014", "")
 .replaceAll("<(.)*>", ""));
 poemes.append(p);
 }
 if(poemes.getString(0).equals(""))poemes.remove(0);        
 
 
 }
 catch(IOException e) {
 println("erreur de chargement");
 }
 
 return poemes; 
 }*/
