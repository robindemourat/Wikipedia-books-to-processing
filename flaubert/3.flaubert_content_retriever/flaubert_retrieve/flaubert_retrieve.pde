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
  JSONObject meta = loadJSONObject("flaubert_refined_index.json").getJSONObject("meta");
  String url = meta.getString("url");
  output.setJSONObject("meta", meta);

  JSONArray contentGlobalOut = new JSONArray();

  JSONArray parts = loadJSONObject("flaubert_refined_index.json").getJSONArray("content");
  JSONArray partsOut = new JSONArray();

  for (int i = 0; i < parts.size (); i++) {
    JSONObject part = parts.getJSONObject(i);
    part.setString("title", part.getString("title").replaceAll("\u2014", "-"));

    JSONArray contents = part.getJSONArray("contents");
    JSONArray contentsOut = new JSONArray();

    for (int j = 0; j < contents.size (); j++) {
      JSONObject chap = contents.getJSONObject(j);

      chap.setJSONArray("paragraphs", parseParagraphs(chap.getString("link")));
      chap.setString("title", chap.getString("title").replaceAll("\u2014", "-"));
      contentsOut.append(chap);
    }

    part.setJSONArray("contents", contentsOut);
    partsOut.append(part);
  }

  output.setJSONArray("content", partsOut);
  println("ok for saving");
  saveJSONObject(output, "output/flaubert_data.json");
  println("done saving");

  exit();
}


JSONArray parseParagraphs(String url) {
  JSONArray output = new JSONArray();
  try {
    Document doc = Jsoup.connect(url).get(); 
    println("parsing "+url);
    Element container = doc.getElementById("mw-content-text");
    Elements ps = container.getElementsByTag("p");

    for (Element p : ps) {
      String pout = p.text()
        .replaceAll("’", "'")
          .replaceAll("\u2026", "...")
            .replaceAll("\u2014", "")
              .replaceAll("[(\\d)*]", "");

      if (trim(pout).length() > 0) {
        if (trim(pout).charAt(0) == '«')
          pout = '-' + pout;
      }
      if(pout.length() > 0)
        output.append(pout);
    }
  }
  catch(IOException e) {
    println("IOException with "+url);
  }
  return output;
}

