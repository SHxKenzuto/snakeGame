/* Copyright (C) 2020 SHxKenzuto
    This file is part of snakeGame.
    snakeGame is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    snakeGame is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with snakeGame.  If not, see <http://www.gnu.org/licenses/>.
*/

//Class that defines the entire game

class Game
{
  Snake s;            
  PVector apple_pos;          //Apple position
  int[][] matrix;             //Grid of the game screen (the position with a 1 represent the snake or the apple while the zeroes are empty space)
  int pixle_size;
  int x_index;
  int  y_index;
  boolean apple_eaten;        //Flag set to true when the apple is eaten
  boolean game_over;          //Flag set to true when the player loses
  int score;                  //Variable that contains the user score
  float time_now;             //Actual time
  float time_last;            //Time elapsed from the last updated frame
  float delta;                //Difference between time_now and time_last
  
  //Constructors
  
  Game()
  {
    pixle_size = 10;
    x_index = width/pixle_size;
    y_index = height/pixle_size;
    s = new Snake(x_index, y_index,pixle_size);
    apple_pos = new PVector((int) random(x_index),(int) random(y_index));
    matrix = new int[x_index][y_index];
    apple_eaten = false;
    game_over = false;
    score = 0;
    time_now = 0;
    time_last = 0;
    delta = 0;
  }
  //Methods
  
  //Updates the position of the snake
  void update()
  {    
    PVector temp; 
    time_now = millis();
    delta = time_now - time_last;
    if(delta>=70)                                  //If delta >= treshold then the position is updated, otherwise the snake will keep the same position
    {                                              //The variation of the treshold changes the speed of the snake
      temp = s.body.get(0).copy();
      switch(s.current_direction)                  //The direction of movement is changed accordingly to the value of current_direction
      {
        case 1:
          temp.y = temp.y -1;
          break;
        case 2:
          temp.x = temp.x +1;
          break;
        case 3:
          temp.y = temp.y +1;
          break;
        case 4:
          temp.x = temp.x -1;
          break;
        default:
          break;
      }
 
      if(!s.hit_wall(temp) && !s.body_contact(temp))                                              
      {
        matrix[(int) s.body.get(s.body.size()-1).x][(int) s.body.get(s.body.size()-1).y]=0;                //The last square of the snake is set to 0 in the matrix (it will become empty space)
        for(int i=s.body.size()-1;i>=1;i--)                                                                //The snake is shifted 
        {
          s.body.set(i,s.body.get(i-1));
          matrix[(int) s.body.get(i).x][(int) s.body.get(i).y] = 1;
        }
        s.body.set(0,temp);
        matrix[(int) s.body.get(0).x][(int) s.body.get(0).y] = 1;
      
        if(s.body.get(0).equals(apple_pos)){                                                               //If the apple is eaten
          apple_eaten = true;
          score++;
          s.body.add(new PVector(s.body.get(s.body.size()-1).x,s.body.get(s.body.size()-1).y));            //Add a new piece of tail
          print("Score: "+score+"\n");
        }
      }
      else
      {
        game_over = true;
        gameover();
      }
      delta = 0;
      time_last = time_now;
    }
  }
  
  //Prints the entire game grid
  void show()
  {
    for(int i=0;i<x_index;i++)
    {
      for(int j=0; j<y_index;j++)
      {
        if(matrix[i][j] == 1)
        {
          if(i == apple_pos.x && j == apple_pos.y)
            fill(255,0,0);
          else
            fill(0,255,0);
          rect(i*s.pixle_size,j*s.pixle_size,s.pixle_size,s.pixle_size);
        }  
      } 
    }
  }
  
  //If the apple is eaten or it's game over, a new position for the apple is set
  void set_apple()
  {
    if(apple_eaten || game_over)
    {
      do
      {
        apple_pos.x = (int) random(x_index);
        apple_pos.y = (int) random(y_index);
      }
      while(matrix[(int)apple_pos.x][(int)apple_pos.y] != 0); //checks that the new position doesn't overlap with the snake
      
      apple_eaten = false;
    }
    matrix[(int)apple_pos.x][(int)apple_pos.y] = 1;           //Puts the new position in the grid
  }
  
  //When there is a game over everything is reset
  void gameover()
  {
    score = 0;
    s = new Snake(x_index, y_index,pixle_size);
    matrix = new int [x_index][y_index];
    set_apple();
    game_over = false;
  }
  
  //Checks if the game is won
  boolean game_won()
  {
    boolean f = true;
    int i = 0;
    while(i<(x_index*y_index) && f)
    {
      if(matrix[i/x_index][i%y_index] == 0)
        f = false;
      i++;
    }
    return f;
  }
}
