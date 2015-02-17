class Page {
  String t;
  float x, y, w, h;
  int size, leading;
  PFont font;
  float margin;
  ArrayList<Mot> mots;
  float regleX, regleY;
  Boolean isFull = false;
  

  
  //constructeur de notre classe (équivalent du setup)
  Page(float margin, PFont font, int size, int leading) {
    
    //mise à jour des paramètres reçus à la création de la page
    this.t = t;
    this.margin = margin;
    this.font = font;
    this.size = size;
    this.font = font;
    this.leading = leading;


    x = margin;
    y = margin;
    w = width - (margin*2);
    h = height - (margin*2);

    regleX = x;
    regleY = y;
    mots = new ArrayList<Mot>();
  }

  //cette fonction a deux rôles :
  //- tester si la page est pleine
  //- sinon ajouter un mot en se fondant sur une "règle virtuelle"
  //enregistrée par les deux repères regleX et regleY
  //qui permettent de placer chaque mot
  void ajouterMot(String mot) {
    pushStyle();
    applyTextParams();
    //est-on à la fin de la ligne ?
    if (regleX + textWidth(mot) > x + w) {
      //est-on à la fin de la page ?
      
      if (regleY + leading > y + h) {
        isFull = true;//si oui, la page enregistre qu'elle est pleine
      } else {
        //si tout va bien, placer la "règle" virtuelle à l'endroit
        //où se trouvera le prochain mot
        regleX = x;
        regleY += leading;
      }
    }
    //si la page n'est pas pleine, ajouter le mot à l'endroit de la règle virtuelle
    if (!isFull) {
      Mot nouveauMot = new Mot(mot, regleX, regleY, font, size);
      mots.add(nouveauMot);
      regleX += textWidth(mot + " ");
    }

    popStyle();
  }
  
  //fonction non utilisée dans cet exemple
  //qui permet d'ajouter les mots directement en utilisant la page
  void remplirMots(String texte) {
    String[] motsBruts = texte.split(" ");
    for (int i = 0; i < motsBruts.length; i++) {
      ajouterMot(motsBruts[i]);
    }
  }
  
  //affichage des mots de la page
  void display() {
    pushStyle();
    applyTextParams();
    for (Mot mot : mots) {
      mot.update();
      mot.display();
    }
  }
  
  //cette fonction est appelée à chaque fois qu'on va
  //dessiner le contenu de la page avec ses éléments de style
  void applyTextParams() {
    textFont(font);
    textSize(size);
    textLeading(leading);
  }
}

