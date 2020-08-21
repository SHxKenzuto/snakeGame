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
