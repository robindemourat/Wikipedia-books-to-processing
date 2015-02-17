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
  JSONObject meta = loadJSONObject("durkheim_refined_index.json").getJSONObject("meta");
  String url = meta.getString("url");
  output.setJSONObject("meta", meta);

  JSONArray contentGlobalOut = new JSONArray();

  JSONArray parts = loadJSONObject("durkheim_refined_index.json").getJSONArray("content");
  JSONArray partsOut = new JSONArray();

  for (int i = 0; i < parts.size (); i++) {
    JSONObject part = parts.getJSONObject(i);
    part.setString("title", part.getString("title").replaceAll("\u2014", "-"));

    JSONArray chapters = part.getJSONArray("chapters");
    JSONArray chaptersOut = new JSONArray();

    for (int j = 0; j < chapters.size (); j++) {
      JSONObject chap = chapters.getJSONObject(j);
      chap.setString("title", chap.getString("title").replaceAll("\u2019", "'").replaceAll("\u2014", "-"));

      chap.setJSONObject("content", parseContent(chap.getString("link")));
      //report subchaps
      JSONArray subchaps = chap.getJSONArray("subchapters-structure");
      JSONArray subchapsOut = new JSONArray();
      for (int n = 0; n < subchaps.size (); n++) {
        JSONObject k = subchaps.getJSONObject(n);
        k.setString("title", k.getString("title").replaceAll("\u2019", "'").replaceAll("\u2014", "-"));
        subchapsOut.append(k);
      }
      chap.setJSONArray("subchapters-structure", subchapsOut);

     chaptersOut.append(chap);
    }

    part.setJSONArray("chapters", chaptersOut);
    partsOut.append(part);
  }

  output.setJSONArray("content", partsOut);
  println("ok for saving");
  saveJSONObject(output, "output/durkheim_data.json");
  println("done saving");

  exit();
}


JSONObject parseContent(String url) {
  JSONArray paragraphs = new JSONArray();
  JSONArray references = new JSONArray();
  try {
    Document doc = Jsoup.connect(url).get(); 
    println("parsing "+url);

    //paragraphs
    Elements els = doc.getElementById("mw-content-text").children();
    for (Element container : els) {
      Elements elss = (container.children());
      if (elss.size() > 1) {
        for (Element e : elss) {
          if (e.tag().toString().equals("p") || e.tag().toString().equals("h4")) {
            String r = trim(e.text());
            if (r.length() > 0) {
              r = r.replaceAll("’", "'")
                .replaceAll("\u2019", "'")
                  .replaceAll("\u2026", "...")
                    .replaceAll("\u2014", "")
                      .replaceAll("\u2032", "'")
                      .replaceAll("\u203a", "'");
              paragraphs.append(r);
            }
          }
        }
      }
    }
    //references
    Elements refs = doc.getElementsByClass("references").get(0).children();
    for (int o = 0 ; o < refs.size() ; o++) {
      Element e = refs.get(o);
      String r = trim(e.text().substring(1, e.text().length()));
      r = (o+1) + ". " + r.replaceAll("’", "'")
        .replaceAll("\u2019", "'")
          .replaceAll("\u2026", "...")
            .replaceAll("\u2014", "")
              .replaceAll("\u2032", "'")
              .replaceAll("\u203a", "'");
      references.append(r);
    }

  }
  catch(IOException e) {
    println("IOException with "+url);
  }

  JSONObject output = new JSONObject();
  output.setJSONArray("paragraphs", paragraphs);
  output.setJSONArray("references", references);
  return output;
}

