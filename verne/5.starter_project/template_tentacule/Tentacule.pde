//la tentacule possède un certains nombre de points qu'elle met à jour
class Tentacule {
  float restingDistance = 2;
  float[] diffX;
  float[] diffY;
  float[] distance;
  float[] difference;
  float[] translateX;
  float[] translateY;
  Point[] p;
  float x, y;

  Tentacule(float x, float y, int nbPoints) {
    this.x = x;
    this.y = y;

    p = new Point[nbPoints];
    for (int i = 0; i < p.length; i++) {
      p[i] = new Point(x, y);
    }
    diffX = new float[p.length];
    diffY = new float[p.length];
    distance = new float[p.length];
    difference = new float[p.length];
    translateX = new float[p.length];
    translateY = new float[p.length];
  }

  //inutile de trop regarder ce morceau
  void solve() {
    for (int i = 0; i < p.length-1; i++) {
      // calculate the distance
      diffX[i] = p[i].x - p[i+1].x;
      diffY[i] = p[i].y - p[i+1].y;
      distance[i] = sqrt(diffX[i] * diffX[i] + diffY[i] * diffY[i]) ;

      // difference scalar
      difference[i] = (restingDistance - distance[i]) / distance[i];

      // translation for each Point. They'll be pushed 1/2 the required distance to match their resting distances.
      translateX[i] = diffX[i] * 0.5 * difference[i];
      translateY[i] = diffY[i] * 0.5 * difference[i];

      p[i].x += translateX[i];
      p[i].y += translateY[i];

      p[i+1].x -= translateX[i];
      p[i+1].y -= translateY[i];
    }
  }

  //ce morceau est important
  void display() {
    //les false et true s'expliquent en allant regarder la classe Point
    p[0].move(false, true);//premier point = arrimé à la base de la tentacule (x, y);
    for (int i = 1; i < p.length-1; i++) {
      p[i].move(false, false);
    }
    p[p.length-1].move(true, false);//dernier point = arrimé à la souris si draggé

    solve();

    //dessin des lignes et points de notre tentacule
    //c'est ici que vous pourrez gérer son apparence
    for (int i = 0; i < p.length-1; i++) {
      stroke(0);
      line(p[i].x, p[i].y, p[i+1].x, p[i+1].y);
      noStroke();
      fill(0);
      ellipse(p[i].x, p[i].y, 2, 2);
      ellipse(p[i+1].x, p[i+1].y, 2, 2);
    }
    ellipse(p[p.length-1].x, p[p.length-1].y, 20, 20);
  }
}

