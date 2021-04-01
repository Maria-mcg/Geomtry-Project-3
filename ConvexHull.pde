

Polygon ConvexHullGiftWrapped( ArrayList<Point> points ){
  Polygon cHull = new Polygon();
  
  if(points.size() == 0)
    return cHull;
  
  if(points.size() <= 3) {
    for(int i=0; i < points.size(); ++i)
      cHull.addPoint(points.get(i));
    return cHull;
  }
  
  ArrayList<Point> pointsClone= (ArrayList<Point>) points.clone();
  
  pointsClone.sort(new Comparator<Point>() {
    public int compare(Point p1, Point p2) {
      if(p1.getX() < p2.getX())
        return -1;
       
      if(p1.getX() == p2.getX())
        return 0;
      return 1;
    }
  });
  
  for(int k=0; k < pointsClone.size(); ++k)
    System.out.println("[" + k + "]" + pointsClone.get(k).toString());
  
  Point firstHullPoint= pointsClone.get(0); 
  cHull.addPoint(firstHullPoint);
  pointsClone.remove(0);
  pointsClone.add(firstHullPoint);
  int indexNextLeftPoint=-1;
  
  while(pointsClone.size() > 1) {
    
    int indexLastHullPoint= cHull.p.size()-1;
    Point lastHullPoint= cHull.p.get(indexLastHullPoint);
    indexNextLeftPoint= -1;
    Point nextLeftPoint= null;
    PVector nextLeftVector= null;
    
    for(int j=0; j < pointsClone.size(); ++j) {
      
      if(nextLeftPoint == null) {
        indexNextLeftPoint= j;
        nextLeftPoint= pointsClone.get(j);
        nextLeftVector= new PVector(nextLeftPoint.p.x - lastHullPoint.p.x, nextLeftPoint.p.y - lastHullPoint.p.y);
        continue;
      }
      
      Point candidatePoint= pointsClone.get(j);
      PVector candidateVector= new PVector(candidatePoint.p.x - lastHullPoint.p.x, candidatePoint.p.y - lastHullPoint.p.y);
      
      if(candidateVector.cross(nextLeftVector).z < 0) {
        indexNextLeftPoint= j;
        nextLeftPoint= candidatePoint;
        nextLeftVector= candidateVector;
      }
    }
    
    if(indexNextLeftPoint == pointsClone.size() - 1)
      break;
    
    cHull.addPoint(nextLeftPoint);
    pointsClone.remove(indexNextLeftPoint);
  }
  
  return cHull;
}
