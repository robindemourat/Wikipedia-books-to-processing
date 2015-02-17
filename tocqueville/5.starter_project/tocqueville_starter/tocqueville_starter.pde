//starter tocqueville
//à voir pour la partie viz : 
//https://processing.org/examples/polartocartesian.html
//exemple de classe permettant de prototyper un texte
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
ArrayList<Page> pages;
int activePage = 1;

//variables relatives à la possibilité de dragger un mot
String motActif;
Mot motTemp;

//viz d'exemple
Viz viz;

void setup() {

  size(800, 600);

  //chargement des données
  donnees = loadJSONObject("tocqueville_data.json");
  //pour ce starter, on choisit un seul chapitre du texte
  JSONArray texte = donnees.getJSONArray("content")//nous donne la liste des parties
    .getJSONObject(0)//on choisit la partie 1
      .getJSONObject("content")//nous donne les références et paragraphes de cette partie
          .getJSONArray("paragraphs");


  //initialisation des paramètres
  font = createFont("Arial", 12);
  margin = width/10;
  size = 14;
  leading = 17;
  fill(0);

  //initialisation des pages
  int numPage = 1;//numéro de page active qui nous permettra de savoir quelle page afficher
  pages = new ArrayList<Page>();
  Page page = new Page(margin, font, size, leading, numPage);

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

      //si la page n'est pas pleine, ajouter le mot
      if (!page.isFull) {
        page.ajouterMot(mots[i]);
        //sinon enregistrer la page et en créer une nouvelle
      } else {
        pages.add(page);
        numPage++;
        page = new Page(margin, font, size, leading, numPage);
      }

      //si on arrive à la fin du paragraphe, et qu'on n'est pas en fin de page, sauter une ligne
      if (i == mots.length - 1 && page.regleY + page.leading*2 < page.y + page.h) {
        page.regleY += page.leading*2;
        page.regleX = page.x;
      }
    }
  }
  //pour finir, on ajoute la dernière page qui était en cours de remplissage
  pages.add(page);


  //motTemp va nous servir à gérer les évènements de dragg
  motTemp = new Mot("", 0, 0, font, size);
  
  
  //initialisation de la viz
  viz = new Viz(margin/2, margin, width/2 - margin);
}

void draw() {
  background(255);

  //aller chercher la page active
  pages.get(activePage-1).display();  
  
  viz.updateColorFromNumPage(activePage-1, pages.size());
  viz.display();
  
  
  //cas dans lequel le mot draggable est visible
  if (motTemp.isVisible) {
    motTemp.highlight = true;
    motTemp.display();
  }
  
 
}

