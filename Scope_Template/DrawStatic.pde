void DrawStatic()
{
    //Draw titles
    background(0);
    stroke(255);
    fill(255);
    textAlign(CENTER);
    text("NU Scope v1.0", width/2, 20);
    textAlign(LEFT);

    //Draw running indicatior
    stroke(255);
    fill(255);
    RunningIndicator += 0.3;
    arc(20, 20, 20, 20, RunningIndicator, (240 * PI/180) + RunningIndicator);
    stroke(0);
    fill(0);
    arc(20, 20, 15, 15, 0, 2 * PI);
}
