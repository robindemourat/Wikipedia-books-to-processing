//gestion des pages
//pourrait être géré avec un élément visible
//par exemple un bouton controlp5 : http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5button/ControlP5button.pde
void keyPressed() {
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


void mouseDragged() {
  //mis à jour de notre mot volant
  motTemp.isVisible = true;
  if (motTemp.t.equals(""))motTemp.t = motActif;
  motTemp.x = mouseX;
  motTemp.y = mouseY;

  //mise à jour de la taille de la police (animation de grossissement)
  if (motTemp.size < 30)
    motTemp.size ++;
}

//quand la souris est lâchée, réinitialiser motTemp
void mouseReleased() {
  motActif = "";
  motTemp.t = motActif;
  motTemp.size = size;
}
