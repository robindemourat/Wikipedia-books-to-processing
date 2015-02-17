//starter homere
//exemple avec le premier chant
//le texte est modélisé au moyen de deux classe
//la classe de base est la classe Mot, qui possède les méthodes et variables pour afficher un mot seul
//la classe Page se charge d'organiser les mots sur l'écran

//cette exemple stocke les éléments dans des tableaux ArrayList
//plus d'information sur leur fonctionnement : https://www.processing.org/reference/ArrayList.html

//variables de stockage des données
JSONObject donnees;

//variables de paramétrage du texte
float margin;
PFont font;
int size, leading;

//gestion de pages - pourrait être complexifié en créant une classe chapitre qui contient des pages par exemple
Page page;
float displaceY = 0; //cette variable va nous permettre d'afficher nos mots relativement au niveau de scroll


void setup() {

  size(400, 700);

  //chargement des données
  donnees = loadJSONObject("homere_data.json");
  //pour ce starter, on choisit un seul chapitre du texte
  JSONArray texte = donnees.getJSONArray("content")//nous donne la liste des chants
    .getJSONObject(0)//on choisit le chant 0
      .getJSONArray("contents");//nous donne la liste des chapitres de cette partie



  //initialisation des paramètres
  font = createFont("Arial", 12);
  margin = width/10;
  size = 14;
  leading = 17;
  fill(0);

  //initialisation de la page
   page = new Page(margin, font, size, leading);

  //remplissage des pages
  //on applique la méthode suivante :
  //- découper chaque paragraphes mot par mot
  //- remplir la page en cours avec ces mots
  //- sauter une ligne à chaque paragraphe (qui correspond à un élément de liste des données initiales)
  //- une fois que la page est pleine, créer une nouvelle page


    //début de l'algorithme
  for (int j = 0; j < texte.size (); j++) {
    //découper le texte du paragraphe en cours en mots
    String[] mots = texte.getString(j).split(" ");
    for (int i = 0; i < mots.length; i++) {
        page.ajouterMot(mots[i]);
      //si on arrive à la fin du paragraphe, et qu'on n'est pas en fin de page, sauter une ligne
      if (i == mots.length - 1) {
        page.regleY += page.leading*2;
        page.regleX = page.margin;
      }
    }
  }


}

void draw() {
  background(255);

  page.display();  //afficher la page
}

