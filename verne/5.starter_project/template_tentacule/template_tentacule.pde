//exemple de tentacule
//adapté de http://www.openprocessing.org/sketch/100877

Tentacule tentacule;

Boolean dragging = false;//variable qui va nous permettre de gérer quand on se trouve en situation de dragging ou pas
 
void setup() {
  size(680, 680);
  stroke(255, 100);
  float x = width/2;
  float y = 0;
  //on créer un array de points qu'on va insérer dans notre tentacule
  tentacule = new Tentacule(x, y, 30);//création de la tentacule
}
 
void draw() {
  background(255);
  tentacule.display();
}
 

