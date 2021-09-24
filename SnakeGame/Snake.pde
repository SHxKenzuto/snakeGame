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

class Snake
{
  ArrayList<PVector> body;
  int pixle_size;            //Size of a single square of the game grid
  int start_x;               //Startig point x
  int start_y;               //Starting point y
  int x_index;               //Game matrix maximum x
  int y_index;               //Game matrix maximum y
  int initial_size;          //Initial snake length
  int current_direction;       //W:1  D:2  S:3  A:4 
  
  //Constructors
  
  Snake()
  {
    pixle_size = 10;
    start_x = width/(2*pixle_size);
    start_y = height/(2*pixle_size);
    x_index = width/pixle_size;
    y_index = height/pixle_size;
    initial_size = 4;
    current_direction = 4;
    body = new ArrayList<PVector>();
    for(int i = 0;i<initial_size;i++)
    {
      body.add(new PVector(start_x+i,start_y));
    }
  }
   Snake(int x, int y, int px_sz)
  {
    pixle_size = px_sz;
    start_x = width/(2*pixle_size);
    start_y = height/(2*pixle_size);
    x_index = x;
    y_index = y;
    initial_size = 4;
    current_direction = 4;
    body = new ArrayList<PVector>();
    for(int i = 0;i<initial_size;i++)
    {
      body.add(new PVector(start_x+i,start_y));
    }
  }
  
  //Methods
  
  //Returns true if a wall will be hit in the next step
  boolean hit_wall(PVector future_pos)
  {
    boolean result = false;
    if(future_pos.x < 0 || future_pos.y < 0 || future_pos.x>=x_index || future_pos.y>=y_index){
      result = true;
    }
    return result;
  }
  
  //Returns true if the snake will touch its body in the next step
  boolean body_contact(PVector future_pos)
  {
    for(int i = 0;i<body.size()-1;i++)
    {
      if(future_pos.equals(body.get(i)))
        return true;
    }
    return false;
  }
  
  //Sets the keys that control the snake movement
  void controls()
  {
    if(keyPressed)
    {
      switch(key)
      {
          case 'W':
          case 'w':
            if(current_direction != 3)
              current_direction = 1;
            break;
          case 'A':
          case 'a':
            if(current_direction != 2)
              current_direction = 4;
            break;
          case 'S':
          case 's':
            if(current_direction != 1)
              current_direction = 3;
            break;
          case 'D':
          case 'd':
            if(current_direction != 4)
              current_direction = 2;
            break;
          default:
            break;
      }
    }
  }  
}
