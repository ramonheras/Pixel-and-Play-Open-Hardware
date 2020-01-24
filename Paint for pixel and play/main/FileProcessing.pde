/* This class is based on an original Make-a-tronik program available at
your gitHub repository, available at this address: https://gist.github.com/Make-a-tronik/6068679
*/
import java.util.Date;

class FileProcessing{
  
    PrintWriter output; // Permite la creacion de archivos
    String path = sketchPath(); // Variable para guardar la ruta de archivo
    String fileName; // Variable para el nombre del archivo
    int id = 1; // id del archivo, se usa para renombrar
    
    // Constructor de la clase
    FileProcessing(String fileName){
      
      this.fileName = fileName;
      if (exist(this.fileName)){ 
        rename();  
        output= createWriter(this.fileName);  //Se crea el archivo con el nombre nuevo
      } else{
        output= createWriter(this.fileName); //Si no existe, se crea sin renombrar
      }
    }
    
    //Crea una lista de los archivos existentes en el directorio actual
    //recibe como parametro la ruta actual
    String[] listFileNames(String dir){  
      
        File file = new File(dir);  //Crea un objeto de la clase File
        
        if (file.isDirectory()) {  //Comprobamos que sea un directorio y no un archivo
            String names[] = file.list();  //Cargamos la lista de archivos en el vector names[]
            return names;  
            
        } else{
          return null;  //En caso de que sea un archivo se devuelve null
        }
    }
    
    //Comprueba si el archivo ya existe
    //recibe como parametro el nombre del archivo
    boolean exist(String fileName){ 
      
        //llama a la funcion listFileNames para obtener la lista de archivos
        String[] filenames = listFileNames(path);  
        
        //Se comprueba por medio de un for la existencia del archivo, recorre todo el vector
        for (int i=0; i<=filenames.length-1;i++){ 
          //Si el nombre de un archivo existente coincide con el que se propuso
            if (fileName.equals(filenames[i])){  
                return true;  
            }
        }
        
        return false;  
    }
    
    // TODO: cambiar recursividad por while(exist()) id++
    //Renombra el archivo para no sobreescribir
    void rename(){
        //Al nombre original se le asigna un indicador haciendo uso del id
        String newName=(split(fileName, ".")[0]+"_"+str(id)+"."+split(fileName, ".")[1]); 
        
        //Se comprueba si archivo con el nuevo nombre existe
        if (exist(newName)){  
            id++;  //Se incrementa id hasta que se encuentra un archivo inexistente
            rename();  //Es recursiva en caso de que siga exisitiendo el nombre
        } else{
          fileName=newName;  //Se regresa el nuevo nombre
        }
    }
    
    //Cierra el archivo, para que sea utilizable
    void close(){
      
        output.flush();  //Vaciamos buffer de escritura
        output.close();  //Cerramos el archivo
    }
    
     //Escribe datos nuevos
    void write(String data){
      
      output.print(data);  //Concatena los datos nuevos y asigna fin de linea
    }

} // Termina la clase
