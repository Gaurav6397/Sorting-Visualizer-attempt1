import javax.swing.JOptionPane;
int[] array;
float speed = 30;
int totalComparisons = 0;
int comparisonsMade = 0;
int swapsMade = 0;
void setup() {
  size(2000, 1000);
  array = new int[200];
  int n = array.length;
  totalComparisons = calcTotalComparisons();
  for (int i = 0; i < n; i++) {
    array[i] = int(random(height));
  }
}
int i = 0, j = 0;

void draw() {
  background(0);
  int rect_width = width/array.length;
  if(i>=array.length){
    for(int k=0; k<array.length; k++){
      fill(color(255, 255, 0));
      rect(k*rect_width ,height-array[k],rect_width, array[k]);
    }
  }
  else{
  for (int k = 0; k < array.length; k++) {
    if(k==j || k==j+1){
      fill(color(255, 0, 0));
    }
    else if(k>array.length-i){
      fill(color(0, 255 , 0));
    }
    else
      fill(color(255, 255, 255));
    rect(k * rect_width, height - array[k], rect_width, array[k]);
  }

  // Bubble Sort Step
  if (i < array.length) {
    if (j < array.length - i - 1) {
      if (array[j] > array[j + 1]) {
        int temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;
        swapsMade++;
      }
      j++;
      comparisonsMade++;
    } else {
      j = 0;
      i++;
    }
  }
  }
  float progress = (comparisonsMade/float(totalComparisons))*100;
  fill(255, 0, 0);
  textSize(26);
  text("Progress: " + int(progress) + "%", 10, 30);
  
}
void keyPressed() {
  if (key == 'f' || key == 'F') {
    speed = constrain(speed + 5, 5, 60); // Increase speed
    frameRate(speed);
  } else if (key == 's' || key == 'S') {
    speed = constrain(speed - 5, 5, 60); // Decrease speed
    frameRate(speed);
  } else if(key == 'r' || key == 'R'){
    resetArray();
  } else if(key == 'c' || key == 'C'){
    customizeArray();
  }
}
void resetArray(){
  String input = JOptionPane.showInputDialog("Enter size");
  if(input!=null && !input.trim().isEmpty()){
  int size = Integer.parseInt(input.trim());
  array = new int[size];
  for(int k=0; k<array.length; k++){
    array[k] = int(random(height));
  }
  }
  i = 0;
  j = 0;
  comparisonsMade = 0;
  totalComparisons = calcTotalComparisons();
  loop();

}
void customizeArray(){
  String input = JOptionPane.showInputDialog("Enter array values separated by commas (e.g., 50,100,200):");
  if(input!=null && !input.trim().isEmpty()){
    try{
      String[] parts = input.split(",");
      array = new int[parts.length];
      int max = 0;
      for(int k=0; k<array.length ; k++){
        array[k] = Integer.parseInt(parts[k].trim());
        if(array[k] > max) max = array[k];
      }
      for(int k=0; k<array.length; k++){
        array[k] = (int)((array[k]*1.0/max)*height);
      }
      i=0;
      j=0;
      comparisonsMade = 0;
      totalComparisons = calcTotalComparisons();
      loop();
    }catch(Exception e){
      JOptionPane.showMessageDialog(null, "Invalid input! Please enter numbers separated by commas.");
    }
  }

}
int calcTotalComparisons(){
  int n = array.length;
  return n*(n-1)/2;
}
