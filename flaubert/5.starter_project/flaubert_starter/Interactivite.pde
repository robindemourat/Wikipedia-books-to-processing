//gestion des pages
//pourrait être géré avec un élément visible
//par exemple un bouton controlp5 : http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5button/ControlP5button.pde
void keyReleased() {
  if (keyCode == RIGHT) {
    if (activePage < pages.size())
      activePage++;
    else activePage = 1;
  } else if (keyCode == LEFT) {
    if (activePage > 1)
      activePage--;
    else activePage = pages.size();
  }
}

void mouseReleased() {
  ArrayList<Mot> mots = pages.get(activePage-1).mots;
  for (int i = 0; i < mots.size (); i++) {
    Mot m = mots.get(i);
    if (m.isOver() && m.isSpecial) {
      m.setSpecial(false);
      String selection = m.t;//on commence avec le texte du mot cliqué
      //aller chercher les éléments spéciaux avant
      int n = i;
      //on va chercher les mots avant
      while (n >= 0) {
        n--;
        if (mots.get(n).isSpecial) {
          selection = mots.get(n).t + " " + selection;
          mots.get(n).setSpecial(false);
        } else break;
      }
      
      //on va chercher les mots après
      n = i;
      while (n < mots.size()) {
        n++;
        if (mots.get(n).isSpecial) {
          selection = selection + " " + mots.get(n).t;
          mots.get(n).setSpecial(false);
        } else break;
      }

      println(selection);
    }
  }
}

