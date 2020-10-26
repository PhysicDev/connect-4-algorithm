

int progress = 0;
int stage = 1;
int info_exec = 0;
int info_exec2 = 0;
int info_exec3 = 0;

//import 
import java.util.Vector;


//stratégie
int rotate = 0;

int strat1(){
  rotate ++;
  if(rotate > 6){
     rotate = 0; 
  }
  return(rotate);
}

int lepif(){
  
  return(int(random(0,6)));
}

// alogrithme minimax
int vision(int[][] data,int dist,int x, int y,int distA){
  info_exec = 0;
  info_exec = -1;
  info_exec = 3;
  progress = 0;
  float[] proba = new float[x];
  proba = calcC(data,dist,x,y,distA);
  
  float max=-40000;
  Vector<Integer> indexs = new Vector<Integer>();
  for(int i = 0; i < x; i++){
    if(max > proba[i]){
       continue; 
    }
    if(max == proba[i]){
       indexs.add(i);
    }else{
       indexs = new Vector();
       indexs.add(i);
       max = proba[i];
    }
  }
  println("execution totale : "+info_exec);
  println("execution totale : "+info_exec2);
  println("execution totale : "+info_exec3);
  
  //choisis aux hasard pour départager les probavilités égales
  int choix = 0;
  if(indexs.size() > 1){
    choix = floor(random(indexs.size()));
  }
  println(proba);
  return(indexs.elementAt(choix));
}


float[] calcC(int[][] dataset,int dist,int x, int y,int distA){
  info_exec ++;
  float[] prob = new float[x];
  
  
  if(dist != 0){
    out : for(int j = 0; j < dataset.length;j++){
      
       //verifie les victoires possible
       int yY = gety(j,dataset);
       if(yY != -1){
         int[][] map = map(dataset);
         map[j][yY] = -1;
         if(check_align_focus(dataset.length,dataset[0].length,map,4,j,gety(j,dataset),-1)){
           prob[j] = 100;
           break out;
         }else{
           
            int perte = 7;
            float[] P2 = new float[x];
            out2 : for(int k = 0; k < dataset.length;k++){
              //verifie les défaites possible
              if(gety(k,map) != -1){
                int[][] map2 = map(map);
                map2[k][gety(k,map)] = 1;
                if(check_align_focus(map2.length,map2[0].length,map2,4,k,gety(k,map),1)){
                   P2[k] = -100;
                   break out2;
                 }else{
                   P2[k] = max(calcC(map2,dist-1,x,y,distA-1));
                 }
              }else{
                 perte --;
                 P2[k] = 1000;
              }
              
            }
            if(distA > 0){
              prob[j] = min(P2);
            }else{
              prob[j] = moyenne(P2,7)-((1000/7)*(7-perte));
            }
         }
       }else{
          prob[j] = -1000; 
       }
    }
    
  }else{
     for(int k = 0; k < dataset.length;k++){
       prob[k] = 0;
     }
  }
  
  return(prob);
}


int gety(int col,int[][] data){
  
  
  for(int i = 0; i < data[0].length; i++){
    if(data[col][i] == 0){
      return(i);
    }
  }
  return(-1);
  
}

  
  int check_align(int x, int y, int[][] case_info, int align_needed, int Player){
    
    int output = 0;
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
          if(Player == value){
            output += 1;
          }else{
            output -= 1;
          }
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
          if(Player == value){
            output += 1;
          }else{
            output -= 1;
          }
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
          if(Player == value){
            output += 1;
          }else{
            output -= 1;
          }
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
          if(Player == value){
            output += 1;
          }else{
            output -= 1;
          }
        }
      }
    }
    
    return(output);
  }
  
  
   
 // pour minimiser les calculs cette fonction ne verifie que les allignement d'une case car si il y a un nouvel alignement, il sera forcément la où le joueur vient de jouer sinon il aurait été détécter au ddernier tour
 boolean check_align_focus(int x, int y, int[][] case_info, int align_needed,int PX, int PY,int value){
    
   
    info_exec3 += 1;
   //H
   
   int streak = 0;
   for(int i = PX-3;i <= PX + 3; i ++){
     if(i >= 0 && i < x){
       if(case_info[i][PY] == value){
         streak += 1;
       }else{
         streak = 0; 
       }
       if(streak == 4){
          return(true); 
       }
     }
   }
   
   
   //V
   streak = 0;
   for(int i = PY-3;i <= PY + 3; i ++){
     if(i >= 0 && i < y){
       if(case_info[PX][i] == value){
         streak += 1;
       }else{
         streak = 0; 
       }
       if(streak == 4){
          return(true); 
       }
     }
   }
    
    
   //D1
   streak = 0;
   for(int i = -3;i <= 3; i ++){
     if(PX+i >= 0 && PX+i < x && PY+i >= 0 && PY+i < y){
       if(case_info[PX+i][PY+i] == value){
         streak += 1;
       }else{
         streak = 0; 
       }
       if(streak == 4){
          return(true); 
       }
     }
   }
   
   //D2
   streak = 0;
   for(int i = -3;i <= 3; i ++){
     if(PX-i >= 0 && PX-i < x && PY+i >= 0 && PY+i < y){
       if(case_info[PX-i][PY+i] == value){
         streak += 1;
       }else{
         streak = 0; 
       }
       if(streak == 4){
          return(true); 
       }
     }
   }
   
   
   return(false);
  }








 
