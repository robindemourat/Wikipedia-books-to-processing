
//quand la souris est cliquée, si elle se trouve à moins de 30px de l'extrémité de la tentacule, alors elle est draggée
void mousePressed(){
  Point dernierPoint = tentacule.p[tentacule.p.length - 1];
  if(dist(mouseX, mouseY, dernierPoint.x, dernierPoint.y) < 30)
    dragging = true;
}

//quand la souris est relaché, éteindre l'interrupteur dragging
void mouseReleased(){
  dragging = false;
}
