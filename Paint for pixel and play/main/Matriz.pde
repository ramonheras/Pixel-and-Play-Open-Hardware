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
int coordenadaX;
int coordenadaY;

ColorPaleta pixel;
class Matriz{
  
  ArrayList<ColorPaleta> listaPixels;
  int dx, dy;
  int posx, posy;
  Matriz(int dx, int dy, int posx, int posy){
    
      this.dx = dx;
      this.dy = dy;
      this.posx = posx;
      this.posy = posy;
  }
  
void borrarLienzo(){
  
  
    push();
    translate(posx, posy);
    py = 0;
    for(int j = 0; j < columnas; j++){
       px = 0;
       for(int i = 0; i < filas; i++){
         ColorPaleta matrizInicial = new ColorPaleta(0, 0, 0, 128, px, py);
         MatrizCodigo[i][j] = matrizInicial;
         px = px + 30;
       }
       py = py+30;
     }
     pop();
  
}
  
   boolean onCanvas(int px, int py){
    
    if ((px > posx) && (px < posx+dx*30) && (py > posy) && (py < posy+dy*30)){
    
       return true;
    }
    
    return false;
  }
  void colorearPixel(ColorPaleta colour){
    
      
      colour.dibujarCuadro(); 
  }
  
  int coordenadaXPixel(int px){
    
    int cx;
    boolean encontrado = false;
    
    push();
    translate(posx, posy);
    cx = posx;
    while((!encontrado) && (cx != -1)){
      if ((px > cx) && (px < cx+30)){
         encontrado = true;
         //cx = cx - posx;    
      } else if (px > cx+30){
        
        cx = cx + 30;
        
      } else{
        
        cx = -1;
      }
    }
    pop();
    
    return cx;
  }
  
  int coordenadaYPixel(int py){
    
    int cy;
    boolean encontrado = false;
    
    push();
    translate(posx, posy);
    cy = posy;
    while((!encontrado) && (cy != -1)){
      
      if ((py > cy) && (py < cy+30)){
         encontrado = true;
         // para centrarla en 0
         //cy = cy - posy;
      } else if (py > cy+30){
        
        cy = cy + 30;
        
      } else{
        
        cy = -1;
      }
    }
    pop();
    
    return cy;
    
  }
  
  void dibujarLienzo(){
    
    push();
    translate(posx, posy);
    
    for(int j = 0; j < columnas; j++){
     for(int i = 0; i < filas; i++){
       ColorPaleta matriz;
       matriz = MatrizCodigo[i][j];
       matriz.dibujarCuadro();
     }
   }
   pop();
  
    
  }
  
}
