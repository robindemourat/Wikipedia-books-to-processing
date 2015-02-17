//gestion des pages
//pourrait être géré avec un élément visible
//par exemple un bouton controlp5 : http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5button/ControlP5button.pde
void keyReleased() {
  if (keyCode == RIGHT) {
    if (activePage < pages.size())
      activePage++;
    else quizz.isVisible = true;
  } else if (keyCode == LEFT) {
    if (activePage > 1)
      activePage--;
      
     quizz.isVisible = false;
  }
}
