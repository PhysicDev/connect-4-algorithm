public class grid extends Thread{
  int x,y;
  int[][] case_info;
  float[][] case_age;
  int align_needed;
  
  boolean process = false;
  
  float last_hit = 0;
  
  //pour indiquer la victoire
  int Ax = -1;
  int Ay = -1;
  int sensX = 0;
  int sensY = 0;
  
  // true for red, false for green
  boolean player = true;
  boolean winner = true;
  boolean end = false;
  boolean win = false;
  
  boolean action = false;
  boolean click = false;
  
  
   public void start()
   {
     super.start();
   }
   public void run()
   {
     while(true){
       try{
        Thread.sleep(250); 
       }catch(Exception e){
         
       }
       play();
     }
   }
  grid(int X, int Y, int AN){
     x = X;
     y = Y;
     case_info = new int[X][Y];
     case_age = new float[X][Y];
     align_needed = AN;
  }
  
  void reset(){
      case_info = new int[x][y];
     case_age = new float[x][y];
      
      Ax = -1;
      Ay = -1;
      sensX = 0;
      sensY = 0;
      
      
      player = true;
      winner = true;
      end = false;
      win = false;
      
      action = false;
      click = false;
     
  }
  
  int[][] get_negate(){
    int[][] output = new int[x][y];
    for(int i = 0; i < x; i++){
        for(int j = 0; j < y; j ++){
          if(case_info[i][j] == 1){
              output[i][j] = -1;
          }
          if(case_info[i][j] == -1){
              output[i][j] = 1;
          }
        }
    }
    return(output);
  }
  
  boolean isplay = false;
  
  int max_index(int[] value){
    int i = 0;
    int fi = 0;
    int max = value[0];
    for(int v : value){
      if(max < v){
         max = v;
         fi = i;
      }
      i++;
    }
    return(fi);
  }
  
  void play(){
    if(!isplay){
      isplay = true;
      if(time - last_hit > 1){
        
        if(!player && opponent != 2 && !win){
          process = true;
          //stratégie ?
          boolean placed = false;
          int col = vision(case_info,(int)IA1pow.value,x,y,2);
          println(IA1pow.value);
          //int col = vision2(case_info,(int)IA1pow.value,x,y);
          /**
          int[] result = minimax(get_negate(),(int)IA1pow.value,true);
          println("");
          println(result);
          println("");
          int col = max_index(result);
          **/
          for(int i = 0; i < y; i ++){
            if(case_info[col][i] == 0){
              case_age[col][i] = time;
              case_info[col][i] = -1;
              placed = true;
              break;
            }
          }
          if(placed){
            println(player);
             last_hit = time - 0.6;
             player = !player; 
            println(player);
            println("");
          }
        }else if(player && opponent == 1 && !win){
          process = true;
          //stratégie ?
          boolean placed = false;
          int col = vision(get_negate(),(int)IA2pow.value,7,6,2);
          for(int i = 0; i < y; i ++){
            if(case_info[col][i] == 0){
              case_age[col][i] = time;
              case_info[col][i] = 1;
              placed = true;
              break;
            }
          }
          if(placed){
             last_hit = time - 0.6;
             player = !player; 
          }
        }
      }
      process = false;
      isplay = false;
    }
  }
  
  
  
  void update_grid(int X,int Y,int size){
    
    
    // check de victoire :
    if(check_align()){
      String text = "";
      if(winner){text = "1";}else{text = "0";}
    }
   // check for no winner
    boolean iszero = false;
    for(int i = 0; i < x; i ++){
      if(case_info[i][y-1] == 0){
         iszero = true;
         break;
      }
    }
    if(!iszero){
      winner = false;
      end = true;
    }
    
    /**
    play();
     if(time - last_hit > 1){
      
      if(!player && opponent != -1 && !win){
        //stratégie ?
        boolean placed = false;
        int col = vision(case_info,-1);
        for(int i = 0; i < y; i ++){
          if(case_info[col][i] == 0){
            case_age[col][i] = time;
            case_info[col][i] = -1;
            placed = true;
            break;
          }
        }
        if(placed){
           last_hit = time - 0.6;
           player = !player; 
        }
      }else if(player && opponent == 1 && !win){
        //stratégie ?
        boolean placed = false;
        int col = stratRB(case_info);
        for(int i = 0; i < y; i ++){
          if(case_info[col][i] == 0){
            case_age[col][i] = time;
            case_info[col][i] = 1;
            placed = true;
            break;
          }
        }
        if(placed){
           last_hit = time - 0.6;
           player = !player; 
        }
      }
    }
    **/
    //input
    if(mousePressed && !click){
      click = true;
      if(hover_grid(X,Y,size,mouseX,mouseY)){
        action = true;
      }
    }
    if(!mousePressed && click){
      click = false;
      if(action){
        action = false;
        if(hover_grid(X,Y,size,mouseX,mouseY) && !win){
          boolean placed = false;
          int col = cursor_to_caseX(X,size,mouseX);
          for(int i = 0; i < y; i ++){
            if(case_info[col][i] == 0){
               placed = true;
               if(player){
                 if(opponent != 1){
                   case_age[col][i] = time;
                   case_info[col][i] = 1;
                 }
               }else{
                 if(opponent == 2){
                   
                   case_age[col][i] = time;
                   case_info[col][i] = -1;
                 }else{
                   placed = false;
                 }
               }
               break;
            }
          }
          if(placed){
             player = !player; 
             last_hit = time;
          }
        }
      }
    }
    
    
    
  }
 
  void draw_grid(int X,int Y,int size){
    
    
    
    fill(150,80);
    noStroke();
    if(hover_grid(X,Y,size,mouseX,mouseY)){
      rect(X+(cursor_to_caseX(X,size,mouseX))*size,Y+(cursor_to_caseY(Y,size,mouseY))*size,size,size);
      fill(240,70);
      rect(X+(cursor_to_caseX(X,size,mouseX))*size,Y,size,size*y);
    }
    
    ellipseMode(CORNER);
    for(int i = 0; i < x; i ++){
      for(int j = 0; j < y; j ++){
        float pY = (Y - size/2) +600*(time-case_age[i][j]);
        if(pY >Y+(y-j-0.9)*size){
          pY = Y+(y-j-0.9)*size;
        }
        if(case_info[i][j] == 1){
          fill(#e73c3c);
          ellipse(X+(i+0.1)*size,pY,size*0.8,size*0.8);
        }else if(case_info[i][j] == -1){
          fill(#57d68d);
          ellipse(X+(i+0.1)*size,pY,size*0.8,size*0.8);
        }
      }
    }
    
    fill(250,140+50*sin(time*3));
    if(win){
      for(int k = 0; k < align_needed; k++){
        float pY = (Y - size/2) +600*(time-case_age[(Ax+k*sensX)][(k*sensY+Ay)]);
        if(pY >Y+(y-(k*sensY+Ay)-0.9)*size){
          pY = Y+(y-(k*sensY+Ay)-0.9)*size;
        }
        ellipse(X+(Ax+k*sensX+0.1)*size,pY,size*0.8,size*0.8);
      }
    }
    noFill();
    strokeWeight(1);
    stroke(190);
    
    // dessinne la grille
    for(int i = 0; i <= x; i ++){
      line(X+(i*size),Y,X+(i*size),Y+(y*size));
    }
    for(int i = 0; i <= y; i ++){
      line(X,Y+(i*size),X+(x*size),Y+(i*size));
    }
    //winner
    
    if(end){
      if(win){
        String a = "";
        if(winner){a = "1";}else{a = "2";}
        String T = "le Joueur "+a+" a gagné !!!";
        textFont(modern);
        textSize(30);
        textAlign(CENTER,CENTER);
        text(T,X+(float(x*size)/2),Y-30);
      }else{
        String T = "égalité , personne n'a gagné ...";
        textFont(modern);
        textSize(30);
        textAlign(CENTER,CENTER);
        text(T,X+(float(x*size)/2),Y-30);
      }
    }
    
    if(process){
      String end = "";
       if(floor((time*4)%4) == 0){
         end += "";
       }else if(floor((time*4)%4) == 1){
         end += ".";
         
       }else if(floor((time*4)%4) == 2){
         end += "..";
         
       }else{
         end += "...";
       }
       textSize(20);
       textFont(modern);
       textAlign(CENTER,CENTER);
       text("CHARGEMENT "+end,X+(float(x*size)/2),Y-30);
    }
    
    
  }
  
  
  int[] cursor_to_case(int X,int Y,int size,float Mx, float My){
    int posx = floor((Mx-X)/size);
    int posy = floor((My-Y)/size);
    int[] output = {posx,posy};
    return(output);
  }
  int cursor_to_caseX(int X,int size,float Mx){
    int posx = floor((Mx-X)/size);
    return(posx);
  }
  int cursor_to_caseY(int Y,int size,float My){
    int posy = floor((My-Y)/size);
    return(posy);
  }
  
  boolean hover_grid(int X,int Y,int size,float Mx, float My){
    int posx = floor((Mx-X)/size);
    int posy = floor((My-Y)/size);
    return(posx >= 0 && posx < x && posy >= 0 && posy < y);
  }
  
  boolean check_align(){
    
    // allignement horizontaux
    for(int i = 0; i <= x-align_needed; i++){
      for(int j = 0; j < y; j ++){
        int value = case_info[i][j];
        if(value == 0){
          continue;
        }
        boolean alligned = true;
        for(int k = 0; k < align_needed; k++){
          if(case_info[i+k][j] != value){
             alligned = false;
             break;
          }
        }
        if(alligned){
          win = true; end = true;
          if(value == 1){
            winner = true;
          }else{
            winner = false; 
          }
          Ax = i;
          Ay = j;
          sensX = 1;
          sensY = 0;
          return(true);
        }
      }
    }
    
    // allignement verticaux
    for(int i = 0; i <= y-align_needed; i++){
      for(int j = 0; j < x; j ++){
        int value = case_info[j][i];
        if(value == 0){
          continue;
        }
        boolean alligned = true;
        for(int k = 0; k < align_needed; k++){
          if(case_info[j][i+k] != value){
             alligned = false;
             break;
          }
        }
        if(alligned){
          win = true; end = true;
          if(value == 1){
            winner = true;
          }else{
            winner = false; 
          }
          Ax = j;
          Ay = i;
          sensX = 0;
          sensY = 1;
          return(true);
        }
      }
    }
    
    // alignement en diagonale en haut à droite
    for(int i = 0; i <= y-align_needed; i++){
      for(int j = 0; j <= x-align_needed; j ++){
        int value = case_info[j][i];
        if(value == 0){
          continue;
        }
        boolean alligned = true;
        for(int k = 0; k < align_needed; k++){
          if(case_info[j+k][i+k] != value){
             alligned = false;
             break;
          }
        }
        if(alligned){
          win = true; end = true;
          if(value == 1){
            winner = true;
          }else{
            winner = false; 
          }
          Ax = j;
          Ay = i;
          sensX = 1;
          sensY = 1;
          return(true);
        }
      }
    }
    
    // alignement en diagonale en bas à droite
    for(int i = 0; i <= y-align_needed; i++){
      for(int j = align_needed-1; j < x; j ++){
        int value = case_info[j][i];
        if(value == 0){
          continue;
        }
        boolean alligned = true;
        for(int k = 0; k < align_needed; k++){
          if(case_info[j-k][i+k] != value){
             alligned = false;
             break;
          }
        }
        if(alligned){
          win = true; end = true;
          if(value == 1){
            winner = true;
          }else{
            winner = false; 
          }
          Ax = j;
          Ay = i;
          sensX = -1;
          sensY = 1;
          return(true);
        }
      }
    }
    
    return(false);
  }
}
