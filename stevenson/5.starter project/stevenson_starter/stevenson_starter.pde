//starter project concernant votre passage sur les chapitres
//utilisation de PVector : https://processing.org/reference/PVector.html
//utilisation de ArrayList : https://www.processing.org/reference/ArrayList.html

String[] chapitres;//titre des chapitres bruts
ArrayList<ChapitreElement> chapitresEls;//liste qui va contenir nos objets visuels

void setup(){
  
  size(800,600);
  fill(0);
  
  //charger les données
  JSONArray contents = loadJSONObject("stevenson_data.json").getJSONArray("content");
  chapitres = new String[0];
  
  //construire la liste des chapitres en allant les chercher dans les JSON
  for(int i = 0 ; i < contents.size() ; i++){
    String chapitre = contents.getJSONObject(i).getString("title");
    chapitres = append(chapitres, chapitre);
  }
  
  //création des éléments visuels
  chapitresEls = new ArrayList<ChapitreElement>();
  for(int i = 0 ; i < chapitres.length ; i++){
    ChapitreElement c = new ChapitreElement(chapitres[i], i*10, height/3 + i*20);
    chapitresEls.add(c);
  }
}

void draw(){
  background(255);
  for(ChapitreElement c : chapitresEls){
    c.update();
  }
  for(ChapitreElement c : chapitresEls){
    c.display();
  }
}


//classe basique permettant d'afficher un élément et de le faire bouger
//suggestion : passer par une classe mot pour les faire bouger séparément
class ChapitreElement{
  
  String texte;
  PVector position, direction;//vecteurs permettant de déplacer nos objets
  
  
  ChapitreElement(String texte, float x, float y){
    this.texte = texte;
    position = new PVector(x, y);
    println(position);
    direction = new PVector(random(-1, 1), random(-1,1));
  }
  
  //mettre à jour la place des éléments
  void update(){
    direction.x += random(-0.5,0.5);
    direction.y += random(-0.5, 0.5);
    position.add(direction);
    
    if(position.x < 0 || position.x > width)
      direction.x = -direction.x;
      
    if(position.y < 0 || position.y > height)
      direction.y = -direction.y;
    
  }
  
  //afficher l'élément
  void display(){
    text(texte, position.x, position.y);
  }
  
  float getWidth(){
    return textWidth(texte);
  }
}
