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
int margenX;
int margenY;
int cont;
ColorPaleta cuadro;
ColorPaleta cuadrado;
int red[] = {255, 183, 255, 252, 173, 250, 219, 162, 186, 125, 127, 89, 
             79, 51, 99, 1, 95, 0, 97, 0, 0, 0, 100, 78, 
             3, 3, 0, 2, 149, 0, 52, 152, 83, 255, 170, 99,
             255, 152, 106, 252, 126, 247, 137, 175, 141, 255, 119, 0};
int green[] = {0, 0, 0, 133, 0, 5, 2, 107, 0, 3, 0, 10, 
               0, 2, 97, 0, 82, 81, 212, 185, 115, 71, 2, 0,
               255, 152, 255, 175, 255, 95, 229, 242, 131, 255, 175, 103, 
               188, 112, 78, 139, 70, 177, 27, 99, 176, 255, 119, 0}; 
int blue[] = {0, 0, 89, 175, 61, 177, 205, 159, 255, 170, 240, 160, 121, 
              252, 160, 224, 219, 250, 250, 252, 250, 155, 95, 155, 
              206, 123, 99, 69, 191, 37, 0, 0, 0, 0, 44, 0, 
              3, 0, 0, 0, 0, 130, 0, 99, 111, 255, 121, 0};


class Paleta{
  
  ArrayList<ColorPaleta> listaColores;
  int posx;
  int posy;
  int dx;
  int dy;
  Paleta(int posx, int posy, int dx, int dy){
    
     this.posx = posx;
     this.posy = posy;
     this.dx = dx;
     this.dy = dy;
  }
  
  void dibujarPaleta(){
    
    push();
    translate(posx, posy);
    rect(0, 0, dx, dy);
    margenY = posy;
    cont = 0;
    listaColores = new ArrayList<ColorPaleta>();
    pop();
    for(int i = 0; i < 4; i++){
      margenX = posx;
      for(int j = 0; j < 12; j++){ 
         cuadro = new ColorPaleta(red[cont], green[cont], blue[cont], 0, margenX, margenY);
         listaColores.add(cuadro);
         cuadro.dibujarCuadro();
         margenX = margenX + 30;
         cont++;
      }
       margenY = margenY + 30;
    }
  }
  
  boolean onPalette(int px, int py){
    
    if ((px > posx && px < posx+dx) && (py > posy) && (py < posy+dy)){
    
       return true;
    }
    
    return false;
  }
  
 ColorPaleta detectaColorPaleta(int px, int py){
   
   
   int i = 0;
   boolean encontrado = false;
   
   push();
   translate(posx, posy);
   while((!encontrado) && (i < 48)){
     
     cuadrado = listaColores.get(i);
     if ((px > cuadrado.posx) &&  (px < cuadrado.posx+30) && 
         (py > cuadrado.posy) && (py < cuadrado.posy+30)){
           
           encontrado = true;
     } else{
       i++;
     }
     
   }
   pop();
   
   return cuadrado;
   
 }
 
    
}
