//proposition de starterproject utilisant controlp5
import controlP5.*;


ControlP5 cp5;
JSONObject data;
JSONArray poemes;

String textValue = "Ecrire ici";
String strophe = "Test";
Textarea area;//objet qui représente la zone de l'utilisateur
Textarea poeme;//objet qui représente la zone du poème
StringBuilder sb;//stringbuilder est une classe java permettant de gérer plus souplement des chaînes de caractère


int marge;

void setup() {
  //charger les données
  data = loadJSONObject("baudelaire_data.json");
  poemes = data.getJSONArray("content").getJSONArray(1);

  size(400, 700);
  marge = (int) width/10;

  cp5 = new ControlP5(this);
  PFont font = createFont("arial", 20);
  textFont(font);


  cp5.addBang("strophe au hasard")
    .setPosition(marge, marge)
      .setSize(width - marge*2, marge)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;

  poeme = cp5.addTextarea(
  "strophe", 
  stropheAuHasard(poemes), 
  marge, marge*2 + 10, width - marge*2, 100)
    .setColor(0).setFont(font);


  area = cp5.addTextarea(
  "input", 
  textValue, 
  marge, marge*4, width - marge*2, width - marge*5).setFont(font);

  area.setColor(0);

  sb = new StringBuilder();



  cp5.addBang("recommencer")
    .setPosition(marge, height - marge*2)
      .setSize(width - marge*2, marge)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;
}

//rien dans draw, car controlp5 gère lui-même ses objets
void draw() {
  background(255);
}

//exemple de fonction pour récupérer une strophe de poème
String stropheAuHasard(JSONArray poemes) {
  String strophe = "";
  int compteur = 0;//ce compteur compte le nombre de tentatives
  //chercher une strophe au hasard et recommencer tant qu'on ne tombe pas sur une strophe vide
  do {
    //prendre un index de poème au hasard
    int poemeHasard = (int) random(0, poemes.size());
    JSONArray poeme = poemes.getJSONObject(poemeHasard).getJSONArray("contents");
    //dans le poeme, prendre un index de strophe au hasard
    int stropheHasard = (int) random(0, poeme.size());
    strophe = poeme.getString(stropheHasard);
    compteur++;
  }
  while (trim (strophe).equals("") && compteur < 20);
  //si vingt tentatives sont passées, prendre la première strophe
  if (trim(strophe).equals(""))
    strophe = poemes.getJSONObject(0).getJSONArray("contents").getString(0);
  //à la fin, renvoyer la strophe
  return strophe;
}

//cette fonction met à jour l'objet poeme avec une strophe au hasard
public void reload(){
  String p = stropheAuHasard(poemes);
  poeme.setText(p);
}


//base de gestion des inputs claviers
void keyPressed()
{
  if (keyCode == RETURN) {
    sb.deleteCharAt(sb.length() - 1);
  } else {
    sb.append( key );
    area.setText( sb.toString() );
  }
}

