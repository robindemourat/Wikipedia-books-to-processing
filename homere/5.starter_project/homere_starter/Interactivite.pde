//gestion du scroll
//pourrait être géré avec un élément visible
//par exemple un bouton controlp5 : http://www.sojamo.de/libraries/controlP5/examples/controllers/ControlP5button/ControlP5button.pde
void keyPressed() {
  if (keyCode == UP) {
        displaceY ++;
  } else if (keyCode == DOWN) {
        displaceY --;
  }
}
void mouseDragged(){
  displaceY -= (pmouseY - mouseY);
}
