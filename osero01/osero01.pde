int onStageLocation[] = {0, 0};
int stage[][] = {
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 1, 2, 0, 0, 0}, 
  {0, 0, 0, 2, 1, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}
};
int saveStage[] = new int[65];
int buckupStage[][] = new int[1000000][65];


int nowPlayer = 1;
int turn = 1;


void setup()
{
  saveStage();
  backup(0);
  size(1000, 1000);

}
void draw()
{
  background(122);
  int i;
  stroke(0);
  for(i = 1;i < 10; i++)
  {
    line(100 * i, 100, 100 * i, 900);
    line(100, 100 * i, 900, 100 * i);
  }
  noStroke();
  for(int m = 0;m < 8;m++)
  {
    for(int n = 0;n < 8;n++)
    {
      if(isStageOnX(100 * (m + 1))&&isStageOnY(100 * (n + 1)))
      {
        onStageLocation[0] = m;
        onStageLocation[1] = n;
      }
      switch (stage[m][n])
      {
        case 0:
          fill(180);
          break;
        case 1:
          fill(0);
          break;
        case 2:
          fill(255);
          break;
      }
      ellipse(50 + 100 * (m + 1), 50 + 100 * (n + 1), 100, 100);
      textSize(32);
      text(str(mouseX) +";"+str(mouseY), 50, 50);
      
    }
  }
  
}

void mousePressed()
{
  int putStageX = onStageLocation[0];
  int putStageY = onStageLocation[1];
  stage[putStageX][putStageY] = nowPlayer;
  judgeRight(putStageX, putStageY);
  judgeLeft(putStageX, putStageY);
  judgeUp(putStageX, putStageY);
  judgeDown(putStageX, putStageY);
  judgeDownRight(putStageX, putStageY);
  judgeUpRight(putStageX, putStageY);
  judgeDownLeft(putStageX, putStageY);
  judgeUpLeft(putStageX, putStageY);
  nowPlayer = (nowPlayer == 1)?2:1;
  backup(turn);
  turn++;
}

void judgeRight(int targetX, int targetY)
{
  if(targetX == 7)
  {
    return;
  }
  int targetPx = 0;
  for(int targetSx = targetX + 1;targetSx <= 7;targetSx++)
  {
    if(stage[targetSx][targetY] == 0)
    {
      break;
    }
    else if(stage[targetSx][targetY] == nowPlayer)
    {
      targetPx = targetSx;
      break;
    }
  }
  for(;targetPx > targetX;targetPx--)
      {
        stage[targetPx][targetY] = nowPlayer;
      }
}

void judgeLeft(int targetX, int targetY)
{
  if(targetX == 0)
  {
    return;
  }
  int targetPx = 7;
  for(int targetSx = targetX - 1;targetSx >= 0;targetSx--)
  {
    if(stage[targetSx][targetY] == 0)
    {
      break;
    }
    else if(stage[targetSx][targetY] == nowPlayer)
    {
      targetPx = targetSx;
      break;
    }
  }
  for(;targetPx < targetX;targetPx++)
      {
        stage[targetPx][targetY] = nowPlayer;
      }
}

void judgeUp(int targetX, int targetY)
{
  if(targetY == 0)
  {
    return;
  }
  int targetPy = 7;
  for(int targetSy = targetY - 1;targetSy >= 0;targetSy--)
  {
    if(stage[targetX][targetSy] == 0)
    {
      break;
    }
    else if(stage[targetX][targetSy] == nowPlayer)
    {
      targetPy = targetSy;
      break;
    }
  }
  for(;targetPy < targetY;targetPy++)
      {
        stage[targetX][targetPy] = nowPlayer;
      }
}

void judgeDown(int targetX, int targetY)
{
  if(targetY == 7)
  {
    return;
  }
  int targetPy = 0;
  for(int targetSy = targetY + 1;targetSy <= 7;targetSy++)
  {
    if(stage[targetX][targetSy] == 0)
    {
      break;
    }
    else if(stage[targetX][targetSy] == nowPlayer)
    {
      targetPy = targetSy;
      break;
    }
  }
  for(;targetPy > targetY;targetPy--)
      {
        stage[targetX][targetPy] = nowPlayer;
      }
}

void judgeDownRight(int targetX, int targetY)
{
  if(targetX == 7 || targetY == 7)
  {
    return;
  }
  int targetPx = 0;
  int targetPy = 0;
  for(int targetSx = targetX + 1, targetSy = targetY + 1;targetSx <= 7 && targetSy <= 7;targetSx++, targetSy++)
  {
    //println(targetSx + ";" + targetSy);
    //println();
    if(stage[targetSx][targetSy] == 0)
    {
      break;
    }
    else if(stage[targetSx][targetSy] == nowPlayer)
    {
      targetPx = targetSx;
      targetPy = targetSy;
      break;
    }
  }
  for(;targetPx > targetX && targetPy > targetY;targetPx--, targetPy--)
      {
        stage[targetPx][targetPy] = nowPlayer;
      }
}

void judgeUpRight(int targetX, int targetY)
{
  if(targetX == 7 || targetY == 0)
  {
    return;
  }
  int targetPx = 0;
  int targetPy = 7;
  for(int targetSx = targetX + 1, targetSy = targetY - 1;targetSx <= 7 && targetSy >= 0;targetSx++, targetSy--)
  {
    if(stage[targetSx][targetSy] == 0)
    {
      break;
    }
    else if(stage[targetSx][targetSy] == nowPlayer)
    {
      targetPx = targetSx;
      targetPy = targetSy;
      break;
    }
  }
  for(;targetPx > targetX && targetPy < targetY;targetPx--, targetPy++)
      {
        stage[targetPx][targetPy] = nowPlayer;
      }
}

void judgeDownLeft(int targetX, int targetY)
{
  if(targetX == 0 || targetY == 7)
  {
    return;
  }
  int targetPx = 7;
  int targetPy = 0;
  for(int targetSx = targetX - 1, targetSy = targetY + 1;targetSx >= 0 && targetSy <= 7;targetSx--, targetSy++)
  {
    if(stage[targetSx][targetSy] == 0)
    {
      break;
    }
    else if(stage[targetSx][targetSy] == nowPlayer)
    {
      targetPx = targetSx;
      targetPy = targetSy;
      break;
    }
  }
  for(;targetPx < targetX && targetPy > targetY;targetPx++, targetPy--)
      {
        stage[targetPx][targetPy] = nowPlayer;
      }
}

void judgeUpLeft(int targetX, int targetY)
{
  if(targetX == 0 || targetY == 0)
  {
    return;
  }
  int targetPx = 7;
  int targetPy = 7;
  for(int targetSx = targetX - 1, targetSy = targetY - 1;targetSx >= 0 && targetSy >= 0;targetSx--, targetSy--)
  {
    if(stage[targetSx][targetSy] == 0)
    {
      break;
    }
    else if(stage[targetSx][targetSy] == nowPlayer)
    {
      targetPx = targetSx;
      targetPy = targetSy;
      break;
    }
  }
  for(;targetPx < targetX && targetPy < targetY;targetPx++, targetPy++)
      {
        stage[targetPx][targetPy] = nowPlayer;
      }
}

boolean isStageOnX(int x)
{
  if(x <= mouseX && x + 100 > mouseX)
  {
    return true;
  }
  return false;
}

boolean isStageOnY(int y)
{
  if(y <= mouseY && y + 100 > mouseY)
  {
    return true;
  }
  return false;
}


void keyPressed()
{
  switch (key)
  {
    case 'z':
      saveStage();
      break;
    case 'v':
      roadStage();
      break;
    case 'b':
      if(turn >= 2)
      {
        backStage(turn);
      }else
      {
        println("これ以上巻き戻せません!!");
      }
      
       
      break;
  }
  
}

void saveStage()
{
  int n = 0;
  for(int y = 0;y <= 7;y++)
  {
    for(int x = 0;x <= 7;x++)
    {
     
      saveStage[n] = stage[x][y];
      if(n != 63)
      {
        n++;
      }
    }
  }
  saveStage[64] = nowPlayer;
  println("pressed[z]key!!");
}

void roadStage()
{
  int n = 0;
  for(int y = 0;y <= 7;y++)
  {
    for(int x = 0;x <= 7;x++)
    {
      stage[x][y] = saveStage[n];
      if(n != 63)
      {
        n++;
      }
    }
  }
  nowPlayer = saveStage[64];
  println("pressed[v]key!!");
}

void backup(int number)
{
  int n = 0;
  for(int y = 0;y <= 7;y++)
  {
    for(int x = 0;x <= 7;x++)
    {
     
      buckupStage[number][n] = stage[x][y];
      if(n != 63)
      {
        n++;
      }
    }
  }
  buckupStage[number][64] = nowPlayer;
}

void backStage(int number)
{
  int n = 0;
  for(int y = 0;y <= 7;y++)
  {
    for(int x = 0;x <= 7;x++)
    {
     
      stage[x][y] = buckupStage[number - 2][n];
      if(n != 63)
      {
        n++;
      }
    }
  }
  nowPlayer = buckupStage[number - 2][64];
  turn = turn - 1;
  println("pressed[b]key!!");
}
