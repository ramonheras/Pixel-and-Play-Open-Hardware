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
class ColorPaleta{
  
  int r;
  int g;
  int b;
  int posx;
  int posy;
  int borde;
  ColorPaleta(int r, int g, int b, int borde, int posx, int posy){
    
    this.r = r;
    this.g = g;
    this.b = b;
    this.posx = posx;
    this.posy = posy;
    this.borde = borde;
  }
  
  void dibujarCuadro(){
    
    push();
    translate(posx, posy);
    stroke(borde);
    fill(r, g, b);
    square(0, 0, 30);
    pop();
    
  }
}
