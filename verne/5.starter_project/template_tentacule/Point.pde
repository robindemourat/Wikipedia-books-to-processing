//la classe point est surtout une classe qui permet de gérer le comportement physique de la chaîne
class Point {
  float x;
  float y;
  float lastX;
  float lastY;
  float nextX;
  float nextY;
  float velX;
  float velY;
  float parentX, parentY;//x et y du point d'arrimage de la tentacule

  Point(float parentX, float parentY) {
    this.parentX = parentX;
    this.parentY = parentY;
  }
  
  //cette fonction prend deux arguments possible = 
  //le premier dit si le point est attaché à la souris ou pas
  //le second dit si le point est attaché à la base de la tentacule
  // ou pas
  void move(boolean pinToMouse, boolean pinToCoordinates) {
    //si le point n'est attaché à rien
    if (pinToMouse == false && pinToCoordinates == false) {
      velX = x - lastX;
      velY = y - lastY;

      velX *= .97;
      velY *= .97;

      nextX = x + velX;
      nextY = y + velY + .1;

      lastX = x;
      lastY = y;

      x = nextX;
      y = nextY;
      //sinon si il est attaché à la souris et qu'on est
      //en situation de drag
    } else if (pinToMouse == true && dragging == true) {
      x = mouseX;
      y = mouseY;
      //sinon si il est attaché à la base de la tentacule
    } else if (pinToCoordinates == true) {
      x = parentX;
      y = parentY;
    }
  }
}

