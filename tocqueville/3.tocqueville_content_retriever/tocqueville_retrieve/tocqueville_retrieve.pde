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
  JSONObject meta = loadJSONObject("tocqueville_refined_index.json").getJSONObject("meta");
  output.setJSONObject("meta", meta);


  JSONArray chapters = loadJSONObject("tocqueville_refined_index.json").getJSONArray("content");
  JSONArray contentsOut = new JSONArray();

  for (int i = 0; i < chapters.size (); i++) {
    JSONObject chapter = chapters.getJSONObject(i);
    chapter.setString("title", chapter.getString("title").replaceAll("\u2014", "-").replaceAll("\u2019", "'"));
    chapter.setJSONObject("content", parseContent(chapter.getString("link")));

    contentsOut.append(chapter);
  }

  output.setJSONArray("content", contentsOut);
  println("ok for saving");
  saveJSONObject(output, "output/tocqueville_data.json");
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
          if (e.tag().toString().equals("p") || e.tag().toString().equals("h2")
            || e.tag().toString().equals("h3") ||e.tag().toString().equals("h4")) {
            String r = trim(e.text());
            if (r.length() > 0) {
              r = r.replaceAll("’", "'")
                .replaceAll("\u2019", "'")
                  .replaceAll("\u2026", "...")
                    .replaceAll("\u2014", "")
                      .replaceAll("\u2018", "'")
                        .replaceAll("\u2032", "'")
                          .replace("[modifier]", "");
              paragraphs.append(r);
            }
          }
        }
      }
    }

    //references
    if (doc.getElementsByClass("references").size() > 0) {
      Elements refs = doc.getElementsByClass("references").get(0).children();

      for (int o = 0; o < refs.size (); o++) {
        Element e = refs.get(o);
        String r = (o+1) + ". " + trim(e.text().substring(1, e.text().length()));
        r = r.replaceAll("’", "'")
          .replaceAll("\u2019", "'")
            .replaceAll("\u2026", "...")
              .replaceAll("\u2014", "")
                .replaceAll("\u2032", "'")
                  ;
        references.append(r);
      }
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

