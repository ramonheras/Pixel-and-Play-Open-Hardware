/*
*
*  Universidad de Málaga (School of Telecommunication)
*  Creative Electronics 
*
*  Developed by:
*  - Manuel Sánchez Natera
*  - Salvador Ruiz Sedeño
*  - Ramón Heras Garcia
*  - Ahmed Adil Mohamed Pérez
*
*/
class Boton{
  
  int dx;
  int dy;
  int posx;
  int posy;
  String texto;
  Boton(int dx, int dy, int posx, int posy, String texto){
    
    this.dx = dx;
    this.dy = dy;
    this.posx = posx;
    this.posy = posy;
    this.texto = texto;
  }
  
  void dibujarBoton(){
    
    push();
    translate(posx, posy);
    fill(200);
    stroke(0);
    rect(0, 0, dx, dy);
    textFont(font);
    fill(0);
    textSize(14);
    text(texto, 20, 30);
    pop();
  }
  
  boolean isPressed(int px, int py){
    
    if ((px > posx && px < posx+dx) && (py > posy) && (py < posy+dy)){
    
       return true;
    }
    
    return false;
  }
  
  
  
}
