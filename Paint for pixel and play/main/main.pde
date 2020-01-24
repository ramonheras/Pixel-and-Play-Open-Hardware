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
Matriz lienzo;
Boton codigo;
Boton borrar;
Paleta paleta;
ColorPaleta colour;
int contadorLetras = 0;
ColorPaleta relleno;
boolean permiso = false;
String nombre;
int r, g, b;
int px, py;
boolean colorSelected = false;
final int columnas = 16;
final int filas = 16;
ColorPaleta MatrizCodigo[][] = new ColorPaleta[columnas][filas];
int indiceX;
int indiceY;
int borde;
PFont font;
PImage pincel;

void setup(){
  
  size(1200, 800);
  //fullScreen(P3D);
  background(255);
  lienzo = new Matriz(columnas, filas, width/2 - columnas*15, height/2 - filas*10);
  codigo = new Boton(150, 50, 70, 50, "Generate Code");
  borrar = new Boton(130, 50, 300, 50, "Clean Canvas");
  paleta = new Paleta(width/2 + 150, height/2 - 370, 360, 120);
  font = loadFont("AvenirNext-Bold-48.vlw");
  pincel = loadImage("pincel.png");
  pincel.resize(45, 45);
  nombre = "";
  
  cursor(HAND);
  
  lienzo.borrarLienzo();
  codigo.dibujarBoton();
  borrar.dibujarBoton();
  paleta.dibujarPaleta();
}

void keyPressed(){
  try{
   if (permiso){
      if ((keyCode == 10) || keyCode == 13){
        if (contadorLetras != 0){
          textoCodigo();
          // Remove blanks at the beginning and end
          trim(nombre);
          permiso = false;
          contadorLetras = 0;
        } 
      } else if (keyCode == 8){
            background(255);
            codigo.dibujarBoton();
            borrar.dibujarBoton();
            paleta.dibujarPaleta();
            lienzo.dibujarLienzo();
            contadorLetras = 0;
            permiso = false;
            nombre = "";
            generarCodigo();
      } else if (teclaValida(keyCode)){
         
         nombre = nombre + str(key);
         contadorLetras++;
         push();
         fill(128);
         textSize(20);
         text(nombre, 340, 170);
         pop();
      }
   }
  } catch(Exception ex) {
    
    text("Error", 40, 700);
    System.out.println("excepcion\n");
    print(ex);
    
  } finally {
    System.out.println("Final\n");
    print("Okey");
  }
}

boolean teclaValida(int tecla){
  
  if ((keyCode >= 48) && (keyCode <= 57)){
    
    return true;
    
  } else if ((keyCode >= 65) && (keyCode <= 90)){
    
    return true;
    
  } else if ((keyCode >= 97) && (keyCode <= 122)){
    
    return true;
    
  } else{
    
    return false;
  }
  
}
void mousePressed(){
  
  if (codigo.isPressed(mouseX, mouseY)){
    
     print("Generating code...\n");
     generarCodigo();
  }
  
 if (paleta.onPalette(mouseX, mouseY)){
   
    colour = paleta.detectaColorPaleta(mouseX, mouseY);
    colorSelected = true;
   
 }
 if (borrar.isPressed(mouseX, mouseY)){
   
      print("Cleaning canvas...\n");
     lienzo.borrarLienzo();
     nombre = "";
     background(255);
 }
 
 if (lienzo.onCanvas(mouseX, mouseY)){
     
     if (colorSelected){
       
       px = lienzo.coordenadaXPixel(mouseX);
       py = lienzo.coordenadaYPixel(mouseY);
       if ((px != -1) && (py != -1)){
         r = colour.r;
         g = colour.g;
         b = colour.b;
         px = px - lienzo.posx;
         py = py - lienzo.posy;
         borde = 128;
         relleno = new ColorPaleta(r, g, b, borde, px, py);
         // To center it at 0 and thus associate it with matrix positions
         indiceX = px/30;
         indiceY = py/30;
         MatrizCodigo[indiceX][indiceY] = relleno;
        } else{
     
           print("Pixel not selected...\n");
        }
      } else{
        
        print("Select a color from the color palette...\n");
      }
      
   } 
   
}

void textoCodigo(){
  
    ColorPaleta matrix;
    String nombreArchivo = nombre + ".ino";
    FileProcessing log = new FileProcessing(nombreArchivo);
    String auxiliar;
    
    push();
    fill(128);
    textSize(20);
    text("Your image code is displayed in the new file...", 60, 210); 
    pop();
    auxiliar = "const uint32_t ";
    log.write(auxiliar);
    auxiliar = nombre;
    log.write(auxiliar);
    auxiliar = "_mat[16][16] = \n"; 
    log.write(auxiliar);
    auxiliar = "{\n";
    log.write(auxiliar);
     for(int j = 0; j < columnas; j++){
       auxiliar = "          {\n";
       log.write(auxiliar);
       for(int i = 0; i < filas; i++){
         
         matrix = MatrizCodigo[i][j];
         auxiliar = "            rgb(";
         log.write(auxiliar);
         auxiliar = str(matrix.r);
         log.write(auxiliar);
         auxiliar = ", ";
         log.write(auxiliar);
         auxiliar = str(matrix.g);
         log.write(auxiliar);
         auxiliar = ", ";
         log.write(auxiliar);
         auxiliar = str(matrix.b);
         log.write(auxiliar);
         if (i == filas-1){
           auxiliar = ")  // x = ";
           log.write(auxiliar);
           auxiliar = str(i);
           log.write(auxiliar);
         } else{
           auxiliar = "),  // x = ";
           log.write(auxiliar);
           auxiliar = str(i);
           log.write(auxiliar);
         }
         auxiliar = " ; y = ";
         log.write(auxiliar);
         auxiliar = str(j);
         log.write(auxiliar);
         auxiliar = "\n"; 
         log.write(auxiliar);
       }
       if (j != columnas-1){
         auxiliar = "          },\n";
         log.write(auxiliar);
       }
     }
     auxiliar = "          }\n";
     log.write(auxiliar);
     auxiliar = "};\n\n\n\n";
     log.write(auxiliar);
     auxiliar = "const Img_t ";
     log.write(auxiliar);
     auxiliar = nombre;
     log.write(auxiliar);
     auxiliar = " = {  &";
     log.write(auxiliar);
     auxiliar = nombre;
     log.write(auxiliar);
     auxiliar = "_mat[0][0],      // data matrix\n";
     log.write(auxiliar);
     auxiliar = "                 ";
     log.write(auxiliar);
     auxiliar = str(columnas);
     log.write(auxiliar);
     auxiliar = ",      // width\n";
     log.write(auxiliar);
     auxiliar = "                 ";
     log.write(auxiliar);
     auxiliar = str(filas);
     log.write(auxiliar);
     auxiliar = "};     // height\n";
     log.write(auxiliar);
     
     log.close();
  
}

void generarCodigo(){
  
  push();
  fill(0);
  textSize(20);
  text("Name the created image:  ", 60, 170);
  pop();
  permiso = true;
  
}


void draw(){
      

    codigo.dibujarBoton();
    borrar.dibujarBoton();
    lienzo.dibujarLienzo();
    paleta.dibujarPaleta();
    if (paleta.onPalette(mouseX, mouseY) || lienzo.onCanvas(mouseX, mouseY)){
      // ponemos un pincel como cursor
      cursor(pincel, 5, 40);
 
    } else{
      cursor(HAND);
    }
}
