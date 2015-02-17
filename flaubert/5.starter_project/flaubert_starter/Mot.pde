//cette classe gère un mot seul

class Mot {
  String t;
  float x, y, w, h;
  int size;
  PFont font;
  Boolean highlight = false;
  Boolean isVisible = true;
  Boolean isSpecial = false;

  //constructeur de notre classe (équivalent du setup)
  Mot(String t, float x, float y, PFont font, int size) {
    
    //on reporte dans la classe les paramètres qui lui ont
    //été transmis à sa création
    this.t = t;
    this.x = x;
    this.y = y;
    this.font = font;
    this.size = size;
    
    //pushStyle et popStyle permettent d'encapsuler les changements de style pour ne pas "contaminer" les autres éléments du sketch
    pushStyle();
    applyTextParams();
    //calcul de la hauteur et de la largeur de l'élément
    w = textWidth(t);
    h = textAscent() + textDescent();
    popStyle();
  }

  //affichage du mot
  void display() {
    pushStyle();
    applyTextParams();
    //cas où l'élément est à mettre en avant
    if (highlight) {
      noStroke();
      fill(250, 249, 217);
      rect(x, y-h, w, h+h/3);
      fill(0);
    }
    
    text(t, x, y);
    
    //cacher si le mot est spécial
    if (isSpecial) {
      noStroke();
      fill(0);
      rect(x, y-h, w, h+h/3);
      fill(0);
    }
    popStyle();
  }
  
  //mise à jour des variables de contrôle du mot
  void update() {
    //test si le mot est survolé
    if (isOver()) {
      highlight = true;
    } else highlight = false;
    
  }
  
  Boolean isOver(){
    return (mouseX > x && mouseX < (x+w) && mouseY > y-h && mouseY < y && !mousePressed);
  }

  void applyTextParams() {
    textFont(font);
    textSize(size);
  }
  
  //cette fonction renvoie un float qui représente la largeur de l'élément
  float getWidth() {
    return textWidth(t);
  }
  
  //cette fonction renvoie un float qui représente la hauteur de l'élément  
  float getHeight() {
    return textAscent() + textDescent();
  }
  
  //fonction qui sert à changer le statut du mot
  void setSpecial(Boolean b){
    this.isSpecial = b;
  }
}

