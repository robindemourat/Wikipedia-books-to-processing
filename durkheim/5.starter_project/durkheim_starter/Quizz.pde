//base pour une classe quizz
//elle est modélisée avec une autre classe question qui vous permettra de gérer vos contenus de manière souple
class Quizz{
  Boolean isVisible = false;
  Question question;
  
  Quizz() {

    //exemple de création de questions réponses
    //à faire = mettre dans un fichier json pour simplifier la lecture
    String q = "Ca parlait de quoi?";
    String[] reponses = {
      "je sais pas", 
      "je sais plus"
    };
    
    question = new Question(q, reponses, 0);
    
  }
  
  
  void display(){
    pushStyle();
    fill(255, 0, 0);
    rect(0, 0, width, height);
    fill(255);

    float position = margin;
    text(question.question, margin, position);
    position += margin;
    
    for(String reponse : question.reponses){
      text(reponse, margin*2, position);
      position += margin;
    }
    popStyle();
  }
}

class Question {
  String question;
  String[] reponses;
  int bonneReponse;
  
  Question(String question, String[] reponses, int bonneReponse) {
    this.question = question;
    this.reponses = reponses;
    this.bonneReponse = bonneReponse;
  }
}

