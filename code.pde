/* @pjs font='fonts/font.ttf' */ 

var myfont = loadFont("fonts/font.ttf");

int width = window.innerWidth - 30;
int height = window.innerHeight - 30;
int gameState = 0;
int beginScene = height/2 - 100;
int mouseRot;
int bOX = 0;
int bOY = 0;
int wr = width;
int dts = 4000;
int oal = 0;
int osn = 0;

ArrayList wisps;

ArrayList men;

ArrayList mts;

ArrayList pcles;

ArrayList chatbar;

Number.prototype.between = function (min, max) {
    return this > min && this < max;
}; 

void setup() {
    size(width,height); 
    textFont(myfont,60);
    wisps = new ArrayList();
    men = new ArrayList();
    pcles = new ArrayList();
    chatbar = new ArrayList();
    mts = new ArrayList();
    for(i = 0; i < 30; i++) {
        men.add(new Man());
    }
}  

void mousePressed() {
    if (gameState == 1) {
        for (int i=mts.size()-1; i>=0; i--) {
            mts.remove(i);
        }
        for (int i=men.size()-1; i>=0; i--) {
            men.remove(i);
        }
        for(i = 0; i < 30; i++) {
            men.add(new Man());
        }
        for (int i=wisps.size()-1; i>=0; i--) {
            wisps.remove(i);
        }
        for (int i=pcles.size()-1; i>=0; i--) {
            pcles.remove(i);
        }
        for (int i=chatbar.size()-1; i>=0; i--) {
            chatbar.remove(i);
        }
        bOX = 0;
        bOY = 0;
        dts = 4000;
        oal = 0;
        osn = 0;
        gameState = 2;
    }
    if (gameState == 0 || gameState == 3 || gameState == 4) {gameState = 1;}
    if (gameState == 2) {
        if (mouseX.between(width -width/20 -width/10, width -width/20) && mouseY.between(height -height/20 -width/10, height -height/20) && wr >= width) {
            for (int i=wisps.size()-1; i>=0; i--) {
                Particle w = (Wisp) wisps.get(i);
                wisps.remove(i);
            }
            wr = 0;
            do {Particle m = (Man) men.get(round(random(men.size() - 1)));} while (m.l = 0);
            m.l = 0;
            m.s = 0;
        } 
        if (dts <= - width/4) {gameState = 3;}
    
    }
}

void draw() {
    background(0);
    if (gameState == 0 || gameState == 1 || gameState == 3 || gameState == 4) {
        textAlign(CENTER);
        textSize(60);
        fill(255);
        text("Bell of Souls",width/2,100 + beginScene);
        if (beginScene > 0) {beginScene -= 5*(beginScene/(height/2 - 100));}
        drawBoat(width/2,height - 90,0.1,1,255 - 255*(beginScene/(height/4)));
    }
    if (gameState == 0 || gameState == 4 || gameState == 3) {
        if (beginScene < (height/4)) {
            textSize(30);
            fill(255,255 - 255*(beginScene/(height/4)));
            text("- Click Anywhere to Prepare -",width/2,height - 30);
        }
    }
    if (gameState == 4) {
        if (beginScene < (height/4)) {
            textSize(60);
            fill(255,255 - 255*(beginScene/(height/4)));
            text("You failed...",width/2,height/2);
        }
    }
    if (gameState == 3) {
        if (beginScene < (height/4)) {
            textSize(60);
            fill(255,255 - 255*(beginScene/(height/4)));
            text("You succeeded!",width/2,height/4);
            textSize(30);
            text("Oarsmen alive: " + oal,width/2,height/4 + 80);
            text("Overall Sanity: " + round(osn*100) + "% Sane",width/2,height/4 + 120);
        }
    }
    if (gameState == 1) {
        if (beginScene < (height/4)) {
            textSize(30);
            fill(255,255 - 255*(beginScene/(height/4)));
            text("You sail in the seas of eternal night to Accordia.",width/2,height/4 + beginScene);
            text("Vengeful spirits will haunt and stress your oarsmen.",width/2,height/4 + beginScene + 30);
            text("For protection, you brought along the Bell of Souls.",width/2,height/4 + beginScene + 60);
            text("Striking it will banish all spirits around at the cost of a man's soul.",width/2,height/4 + beginScene + 90);
            text("You need at least 20 oarsmen to move the ship. Losing too much will result in failure.",width/2,height/4 + beginScene + 120);
            text("- Click Anywhere to Set Sail -",width/2,height-30);
            
        }
    }
    if (gameState == 2) {
        fill(30,0,0);
        stroke(0,0);
        ellipse(100,100,100,100);
        for (int i=mts.size()-1; i>=0; i--) {
            Particle v = (Mt) mts.get(i);
            v.update();
            if (v.gx2 < -10) {mts.remove(i);}
        }
        if (dts <= 100) {
            fill(132,84,47);
            stroke(132,84,47);
            strokeWeight(1);
            rect(width - 100 + dts, (height/4)*3 - 50, width, -50);
            strokeWeight(15);
            line(width - 50 + dts, (height/4)*3 - 100, width - 50 + dts, (height/4)*3 - 200);
            line(width + dts, (height/4)*3 - 100, width + dts, (height/4)*3 - 200);
            strokeWeight(1);
            rect(width - 100 + dts, (height/4)*3 - 200, 150, -60);
            textSize(30);
            fill(255);
            text("Accordia", width - 25 + dts, (height/4)*3 - 230);
        }
        for (int i=men.size()-1; i>=0; i--) {
            Particle m = (Man) men.get(i);
            m.update();
        }
        bOX += random(-0.01,0.01);
        bOY += random(-0.01,0.01);
        if (bOX > 10) {bOX = 10;}
        if (bOX < -10) {bOX = -10;}
        if (bOY > 10) {bOY = 10;}
        if (bOY < -10) {bOY = -10;}
        drawBoat(width/2 + bOX,height/2 - 20 + bOY,0.8,0.5,255);
        fill(0,0,50,200);
        stroke(0,0,50,0);
        rect(0,(height/4)*3 - 50,width,height/4 + 50);
        
        if (random(1) > 0.995 && dts > 400) {
            wisps.add(new Wisp());
            if (dts.between(1000,3000)) {
                wisps.add(new Wisp());
            }
        }
        if (random(1) > 0.995) {mts.add(new Mt());}
        
        for (int i=wisps.size()-1; i>=0; i--) {
            Particle w = (Wisp) wisps.get(i);
            w.update();
            if (w.x < -50) {wisps.remove(i);}
        }
        for (int i=pcles.size()-1; i>=0; i--) {
            Particle p = (Pcle) pcles.get(i);
            p.update();
            if (p.a < 0) {pcles.remove(i);}
        }
        lightBeam(width/2,height/2);
        for (int i=chatbar.size()-1; i>=0; i--) {
            Particle c = (Man) chatbar.get(i);
            c.update();
            if (c.y < 0 || c.a < 0) {chatbar.remove(i);}
        }
        if (wr < width) {
            wr += 1;
            wr *= 1.5;
            stroke(255);
            strokeWeight(10);
            fill(0,0);
            ellipse(width -width/10,height -height/10,wr,wr);
        } 
        stroke(150,0);
        fill(150,100);
        rect(width -width/20, height -height/20, -width/10, -width/10,0.0001);
        strokeWeight(15);
        stroke(255,100);
        line(width -width/9,height -height/15,width -width/10,height -height/5.5);
        fill(0);
        strokeWeight(1);
        stroke(0,0);
        ellipse(width -width/10,height -height/5.5,50,50);
        textAlign(CENTER);
        fill(255);
        textSize(30);
        if (mouseY.between(height/3, (height/3)*2)) {
            if (mouseX.between(width/2,width)) {
                if (dts > 1000) {text("Nothing can be seen...",width/2,30);}
                if (dts <= 1000 && dts > 600) {text("I see something.",width/2,30);}
                if (dts <= 600 && dts > 400) {text("I can see land!",width/2,30);}
                if (dts <= 400 && dts > 100) {text("We are getting closer!",width/2,30);}
                if (dts <= 100) {text("We have survived the journey!",width/2,30);}
            }
            if (mouseX.between(0,width/2)) {
                if (dts <= 3000) {text("I cannot see our island anymore...",width/2,30);}
                if (dts <= 3500 && dts > 3000) {text("It's getting harder to see our island.",width/2,30);}
                if ( dts > 3500) {text("Our island is still in full view.",width/2,30);}
            }
        }
        osn = 0;
        for (int i=men.size()-1; i>=0; i--) {
                Particle m = (Man) men.get(i);
                osn += m.s/men.size();
        }
        oal = 0;
        for (int i=men.size()-1; i>=0; i--) {
                Particle m = (Man) men.get(i);
                if (m.l == 1) {oal += 1;}
        }
        if (oal < 20) {gameState = 4;}
        if (dts > - width/3) {text(oal + " Oarsmen Left",width/2,height-30);}
        if (dts <= - width/3) {text("- Click to View Score -",width/2,80);}
        if (wr >= width) {text("Strike", width -width/10,height -height/10);}
        if (dts > - width/3) {
            for (int i=men.size()-1; i>=0; i--) {
                Particle m = (Man) men.get(i);
                dts -= m.s/men.size();
            }
        }
    }
}

void lightBeam(x,y) {
    fill(0);
    strokeWeight(1);
    stroke(0);
    mouseRot = atan2(mouseY - y, mouseX - x) / PI * 180;
    translate(x,y);
    rotate(mouseRot/180*PI);  
    beginShape();
        vertex(0,0);
        vertex(width*2,-150);
        vertex(width*2,-height*2);
        vertex(-width*2,-height*2);
        vertex(-width*2,height*2);
        vertex(width*2,height*2);
        vertex(width*2,150);
        vertex(0,0);
    endShape();
    rotate(0-mouseRot/180*PI);
    translate(0-x,0-y);
}

void drawBoat(x,y,s,t,a) {
    stroke(255*t,a);
    strokeWeight(5*s);
    // mast
    fill(255*t,a);
    beginShape();
        vertex(x+100*s,y-230*s);
        bezierVertex(x+250*s,y-250*s, x+250*s, y-250*s, x+400*s, y-350*s);
        bezierVertex(x+400*s,y, x+400*s, y, x+180*s, y+100*s);
        bezierVertex(x+320*s,y+45*s, x+100*s, y+10*s, x, y+80*s);
        bezierVertex(x+100*s,y, x+300*s, y-100*s, x+100*s, y-230*s);
    endShape();
    stroke(150*t,a);
    line(x+195*s,y-290*s,x-400*s,y+150*s);
    line(x+195*s,y-290*s,x-180*s,y+150*s);
    line(x+195*s,y-290*s,x-150*s,y+150*s);
    line(x+195*s,y-290*s,x+400*s, y-350*s);
    line(x+400*s, y-350*s,x-300*s,y+150*s);
    line(x, y+80*s,x-140*s,y+150*s);
    line(x+180*s, y+100*s,x-120*s,y+150*s);
    // line in the middle
    stroke(255*t,a);
    fill(255*t,a);
    beginShape();
        vertex(x+190*s,y+170*s);
        vertex(x+195*s,y-300*s);
        vertex(x+210*s,y+190*s);
    endShape();
    fill(132*t,84*t,47*t,a);
    stroke(132*t,84*t,47*t,a);
    // ship
    beginShape();
        vertex(x-380*s,y+90*s);
        vertex(x-400*s,y+100*s);
        vertex(x-410*s,y+110*s);
        vertex(x-420*s,y+125*s);
        vertex(x-425*s,y+140*s);
        vertex(x-425*s,y+155*s);
        vertex(x-420*s,y+170*s);
        vertex(x-415*s,y+180*s);
        vertex(x-410*s,y+190*s);
        vertex(x-400*s,y+200*s);
        vertex(x-395*s,y+205*s);
        vertex(x-390*s,y+210*s);
        vertex(x-370*s,y+220*s);
        vertex(x-340*s,y+230*s);
        vertex(x-300*s,y+240*s);
        vertex(x-220*s,y+250*s);
        vertex(x+300*s,y+240*s);
        vertex(x+500*s,y+230*s);
        vertex(x+555*s,y+180*s);
        vertex(x+600*s,y+80*s);
        vertex(x+555*s,y+120*s);
        vertex(x+500*s,y+130*s);
        vertex(x+300*s,y+140*s);
        vertex(x-380*s,y+150*s);
        vertex(x-390*s,y+140*s);
        vertex(x-395*s,y+130*s);
        vertex(x-395*s,y+120*s);
        vertex(x-380*s,y+90*s);
    endShape();
    stroke(0);
    strokeWeight(5*s);
    for(i = 0; i < 30; i++) {
        Particle m = (Man) men.get(i);
        if ((y+(350 + m.ry)*s) < (height/4)*3 - 50 && dts > - width/3) {
            pcles.add(new Pcle(x-(370 - m.rx - 30*i)*s,y+(350 + m.ry)*s,-0.2,-0.2,0,0,50,random(100),random(15,20)));
        }
        line(x-(370 - 30*i)*s,y+160*s,x-(370 - m.rx - 30*i)*s,y+(350 + m.ry)*s);
    }
    if (gameState == 2 && dts > - width/3) {pcles.add(new Pcle(x+525*s,y+210*s,random(-2,-1),random(-0.2,0.2),0,0,50,random(100),random(15,20)));}
}

class Wisp {
  float x, y, vx, vy, t, b;

  Wisp() {
    x = random(width);
    y = (height/4)*3;
    t = round(random(men.size()-1));
  }
  
  void update() {
      Particle m = (Man) men.get(t);
      if (m.s > 0) {
          m.s -= random(0.001);
          if (dts.between(1000,3000)) {
              m.s -= random(0.002);
          }
      }
      vy += random(-1,1);
      vx += random(-1,1);
      if (y > (height/4)*3) {vy += random(-0.5,0.25);}
      if (y < height/2) {vy += random(-0.25,0.5);}
      if (x > (width/4)*3) {vx += random(-0.25,0.25);}
      if (x < width/4) {vx += random(0.5);}
      if (vx < -3) {vx = -3;}
      if (vx > 3) {vx = 3;}
      if (vy < -3) {vy = -3;}
      if (vy > 3) {vy = 3;}
      b = 0;
      for (int i=men.size()-1; i>=0; i--) {
          Particle m = (Man) men.get(i);
          b += m.s;
      }
      b = b/men.size();
      x += vx - b;
      y += vy;
      if (x > width) {vx = 0 - vx;}
      if (y < 0 || y > height) {vy = 0 - vy;}
      pcles.add(new Pcle(x,y,random(-0.2,0.2),random(0.2),25,100,25,random(100,150),random(5,15)));
  }
}

class Man {
  float rx,ry,xd,yd,s,c,name,fn,l, ntc;
  

  Man() {
    rx = 0;
    ry = 0;
    xd = 0;
    yd = 0;
    s = 1;
    l = 1;
    ntc = round(random(3));
    c = random(1);
    name = chance.word({syllables: round(random(2,5))});
    name = chance.capitalize(name);
    fn = chance.word({syllables: round(random(2,5))});
    fn = chance.capitalize(fn);
  }
  
  void update() {
      if (xd == 0 && l == 1 && dts > - width/3) {rx += 3*s;}
      if (xd == 1 && l == 1 && dts > - width/3) {rx -= 3*s;}
      if (rx > 150 && l == 1 && dts > - width/3) {rx -= 3*s; xd = 1;}
      if (rx < -150 && l == 1 && dts > - width/3) {rx += 3*s; xd = 0;}
      if (yd == 0 && l == 1 && dts > - width/3) {ry += 3*s;}
      if (yd == 1 && l == 1 && dts > - width/3) {ry -= 3*s;}
      if (ry > 150 && l == 1 && dts > - width/3) {yd = 1;}
      if (ry < -150 && l == 1 && dts > - width/3) {yd = 0;}
      if (s > 0 && c > 0.2 && s < 1 && l == 1 && gameState == 2) {s += c*0.001;}
      if (s <= 0 || (s <= 0.4 && random(1) > 0.995)) {l = 0;}
      
      if (l == 0 || dts <= - width/3) {
          if (rx <= 4) {rx += 4;}
          if (rx >= 4) {rx -= 4;}
          if (ry <= 4) {ry += 4;}
          if (ry >= 4) {ry -= 4;}
      }
      ntc = round(random(3));
      if (random(1) > 0.9999 && s <= 1 && s > 0.8 && dts > - width/3) {
          Particle m = (Man) men.get(round(random(men.size() - 1)));
          if (m.s < 1 && m.s >= 0.8) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              switch(ntc) {
                  case 0:
                      chatbar.add(new Chat("Oarsman","Something's wrong with " + m.name + "...", 1));
                      break;
                  case 1:
                      chatbar.add(new Chat("Oarsman",m.name + ", why are you mumbling to yourself?", 1));
                      break;
                  case 2:
                      chatbar.add(new Chat("Oarsman","Bring your hopes up! We're close!", 0));
                      break;
                  case 3:
                      chatbar.add(new Chat("Oarsman","You're getting slow, " + m.name + "!", 1));
                      break;
              }
          }
          if (m.s == 1) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              switch(ntc) {
                  case 0:
                      chatbar.add(new Chat("Oarsman","Keep up the good work, " + m.name + "!", 0));
                      if (random(1) > 0.5) {
                          for (int i=chatbar.size()-1; i>=0; i--) {
                              Particle c = (Chat) chatbar.get(i);
                              c.y -= 30;
                          }
                          chatbar.add(new Chat(m.name,"Thanks!", 0));
                      }
                      break;
                  case 1:
                      chatbar.add(new Chat("Oarsman","Not bad, " + m.name + "!", 0));
                      if (random(1) > 0.5) {
                          for (int i=chatbar.size()-1; i>=0; i--) {
                              Particle c = (Chat) chatbar.get(i);
                              c.y -= 30;
                          }
                          chatbar.add(new Chat(m.name,"Thanks!", 0));
                      } else {
                          for (int i=chatbar.size()-1; i>=0; i--) {
                              Particle c = (Chat) chatbar.get(i);
                              c.y -= 30;
                          }
                          chatbar.add(new Chat(m.name,"You too!", 0));
                      }
                      break;
                  case 2:
                      chatbar.add(new Chat("Oarsman","Let's show the sea what we're made of!", 0));
                      if (random(1) > 0.5) {
                          for (int i=chatbar.size()-1; i>=0; i--) {
                              Particle c = (Chat) chatbar.get(i);
                              c.y -= 30;
                          }
                          chatbar.add(new Chat("Oarsman","Haha!", 0));
                      }
                      break;
                  case 3:
                      chatbar.add(new Chat("Oarsman","This is easy!", 0));
                      if (random(1) > 0.5) {
                          for (int i=chatbar.size()-1; i>=0; i--) {
                              Particle c = (Chat) chatbar.get(i);
                              c.y -= 30;
                          }
                          chatbar.add(new Chat("Oarsman","Yes, not at all hard!", 0));
                      }
                      break;
              }
          }
          if (m.s < 0.8 && m.s >= 0.4) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              switch(ntc) {
                  case 0:
                      chatbar.add(new Chat("Oarsman","Faster, " + m.name + "!", 1));
                      break;
                  case 1:
                      chatbar.add(new Chat("Oarsman",m.name + ", are you seeing ghosts again?", 1));
                      break;
                  case 2:
                      chatbar.add(new Chat("Oarsman","Ignore the spirits, " + m.name + "!", 1));
                      break;
                  case 3:
                      chatbar.add(new Chat("Oarsman","Hang in there, " + m.name + "!", 1));
                      break;
              }
          }
          if (m.s < 0.4 && m.s > 0) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              switch(ntc) {
                  case 0:
                      chatbar.add(new Chat("Oarsman","There are NO spirits, " + m.name + "!", 1));
                      break;
                  case 1:
                      chatbar.add(new Chat("Oarsman","You are getting crazy, " + m.name + "...", 1));
                      break;
                  case 2:
                      chatbar.add(new Chat("Oarsman","Help, " + m.name + "'s going mad!", 1));
                      break;
                  case 3:
                      chatbar.add(new Chat("Oarsman",m.name + "?", 1));
                      break;
              }
          }
          if (m.l == 0) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              switch(ntc) {
                  case 0:
                      chatbar.add(new Chat("Oarsman","Rest in peace, " + m.name + "...", 2));
                      break;
                  case 1:
                      chatbar.add(new Chat("Oarsman","Of all people, why " + m.name + "?", 2));
                      break;
                  case 2:
                      chatbar.add(new Chat("Oarsman","...", 2));
                      break;
                  case 3:
                      chatbar.add(new Chat("Oarsman","Brother...", 2));
                      break;
              }
          }
      }
      if (random(1) > 1 - (0.001 - 0.001*(s/1))) {
          if (s < 1 && s >= 0.8) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              chatbar.add(new Chat("Oarsman","Get away, you mouldy ghost! You are already dead!", 1));
          }
          if (s < 0.8 && s >= 0.6) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              chatbar.add(new Chat("Oarsman","You are not real! Are you, " + fn + "?", 1));
          }
          if (s < 0.6 && s >= 0.4) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              chatbar.add(new Chat("Oarsman","no... stop... Please, I beg you, " + fn + "...", 1));
          }
          if (s < 0.4 && s > 0) {
              for (int i=chatbar.size()-1; i>=0; i--) {
                  Particle c = (Chat) chatbar.get(i);
                  c.y -= 30;
              }
              chatbar.add(new Chat("Oarsman","I can't do this anymore...", 2));
          }
      }
  }
}

class Pcle {
  float x, y, vx, vy, r, g, b, a, c;

  Pcle(ox,oy,ovx,ovy,or,og,ob,oa,oc) {
    x = ox;
    y = oy;
    vx = ovx;
    vy = ovy;
    r = or;
    g = og;
    b = ob;
    a = oa;
    c = oc;
      
  }
  
  void update() {
      x += vx;
      y += vy;
      fill(r,g,b,a);
      stroke(r,g,b,0);
      a -= 2;
      ellipse(x,y,c,c);
  }
}

class Chat {
  float y, m, n, a, t;

  Chat(on,om,ot) {
    y = height - 10;
    n = on;
    m = om;
    t = ot;
    a = 255;
  }
  
  void update() {
      if (t == 0) {
          fill(255,a);
          stroke(255,a);
      }
      if (t == 1) {
          fill(255,255,0,a);
          stroke(255,255,0,a);
      }
      if (t == 2) {
          fill(255,0,0,a);
          stroke(255,0,0,a);
      }
      textSize(20);
      textAlign(LEFT);
      text(n + ": " + m,0,y);
      a -= 0.5;
  }
}

class Mt {
  float x, d, c, px1, py1, px2, py2, gx1, gx2, mv;

  Mt() {
    d = random(2);
    c = random(1);
    px1 = random(width + 200,width + 300);
    px2 = random(width + 500,width + 600);
    gx1 = width;
    gx2 = px2 + random(300);
    py1 = random(0,height/2);
    py2 = random(0,height/2);
  }

  void update() {
      mv = 0;
      for (int i=men.size()-1; i>=0; i--) {
          Particle m = (Man) men.get(i);
          mv += m.s;
      }
      mv = mv/men.size();
      if (dts > - width/4) {
          px1 -= mv*d;
          px2 -= mv*d;
          gx1 -= mv*d;
          gx2 -= mv*d;
      }
      if (c.between(0,0.3)) {
        fill(37,30,1);
      }
      if (c.between(0.3,0.6)) {
          fill(8,37,1);
      }
      if (c.between(0.6,1)) {
          fill(35);
      }
      stroke(0);
      strokeWeight(1);
      beginShape();
          vertex(gx1,(height/4)*3 - 50);
          vertex(px1,py1);
          vertex(px2,py2);
          vertex(gx2,(height/4)*3 - 50);
          vertex(gx1,(height/4)*3 - 50);
      endShape();
  }
}