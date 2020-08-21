/* Copyright (C) 2020 SHxKenzuto
    This file is part of snakeGame.
    inventoryLeap is free software: you can redistribute it and/or modify
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

Game g;

void setup()
{  
  size(1000,800);
  frameRate(120);
  background(0);
  g = new Game();
  g.set_apple();
  g.show();
}

void draw()
{
  background(0);
  g.s.controls();
  g.set_apple();
  g.show();
  if(!g.game_won())
    g.update();
}
