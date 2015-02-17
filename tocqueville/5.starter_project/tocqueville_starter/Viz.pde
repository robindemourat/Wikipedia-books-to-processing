//base pour une classe viz
class Viz{
  float x, y, diametre;
  int r, v, b;
  
  Viz(float x, float y, float diametre){
    this.x = x;
    this.y = y;
    this.diametre = diametre;
    
    r = 250;
    v = 247;
    b = 0;
  }
  
  void display(){
    pushStyle();
    noStroke();
    fill(r, v, b);
    ellipse(x + diametre/2, y + diametre/2, diametre, diametre);
    popStyle();
  }
  
  //exemple d'une fonction qui met à jour la couleur de l'élément en fonction du numéro de page
  void updateColorFromNumPage(int numPage, int nbPages){
    b = (int) map(numPage, 0, nbPages, 0, 255);

  }
}
