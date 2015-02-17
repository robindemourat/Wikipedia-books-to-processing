import org.jsoup.safety.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import org.jsoup.nodes.*;

JSONObject output;
void setup(){
  
  output = new JSONObject();
  JSONObject meta = loadJSONObject("baudelaire_refined_index.json").getJSONObject("meta");
  output.setJSONObject("meta", meta);
  
  JSONArray contentGlobalOut = new JSONArray();
  
  JSONArray parties = loadJSONObject("baudelaire_refined_index.json").getJSONArray("content");
  
  for(int i = 0 ; i < parties.size() ; i++){
    JSONObject partie = parties.getJSONObject(i);
    JSONArray contents = partie.getJSONArray("content");
    JSONArray contentsOut = new JSONArray();
    for(int j = 0 ; j < contents.size() ; j++){
      JSONObject item = contents.getJSONObject(j);
      item.setString("title", item.getString("title").replaceAll("’", "'"));
      JSONArray poemes = parsePoeme(item.getString("link"));
      item.setJSONArray("contents", poemes);
      contentsOut.append(item);
    }
    partie.setJSONArray("content", contentsOut);
    contentGlobalOut.append(contentsOut);
  }
  
  output.setJSONArray("content", contentGlobalOut);
  println("ok for saving");
  saveJSONObject(output, "output/baudelaire_data.json");
  
  exit();
}

JSONArray parsePoeme(String url){
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
}
