void drawStatic()
{
    background(0);
    stroke(255);
    fill(255);
    textAlign(CENTER);
    text("NU Scope v1.0", width/2, 20);
    textAlign(LEFT);
    
    //Draw running indicatior
    stroke(255);
    fill(255);
    runningIndicator += 0.3;
    arc(20, 20, 20, 20, runningIndicator, (240 * PI/180) + runningIndicator);
    stroke(0);
    fill(0);
    arc(20, 20, 15, 15, 0, 2 * PI);

}



void drawStaticScope()
{
    // Graph placeholder
    stroke(color(255));
    fill(20);
    rect(60,80, 620, 140);
    rect(60,240, 620, 140);
    rect(60,400, 620, 24);
    rect(60,440, 620, 24);
    rect(60,480, 620, 24);
    rect(60,520, 620, 24);
    
    stroke(255);
    fill(255);
    text("Scope", windowWidth - 320, 80);
    text("Function Generator", windowWidth - 320, 180);
    text("Square Wave Generator", windowWidth - 320, 300);
    text("Power", windowWidth - 320, 450);
    fill(0,0);
}

void drawStaticPorts()
{
    stroke(255);
    fill(255);
    text("Select Port", 35, 70);
    fill(0, 0);
}
