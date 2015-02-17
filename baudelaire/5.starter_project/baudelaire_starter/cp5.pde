//fonction attachée au bang "recommencer"
public void recommencer() {
  sb.delete(0, sb.length());
  area.setText(sb.toString());
}

//cette fonction gère les évènements de bang qu'on ne peut pas gérer avec la solution plus simple ci-dessus
void controlEvent(ControlEvent theEvent) {
  if(theEvent.getController().getName().equals("strophe au hasard")) {
    reload();
  }
}


