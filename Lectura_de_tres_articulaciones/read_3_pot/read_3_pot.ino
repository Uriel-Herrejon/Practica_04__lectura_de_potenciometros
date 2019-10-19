int pot1 = 0;
int pot2 = 0;
int pot3 = 0;

void setup(){
  Serial.begin(9600);
}

void loop(){
  //Lectura de potenciómetros
  pot1 = analogRead(A0);
  pot2 = analogRead(A1);
  pot3 = analogRead(A2);

  //Envío de información 
  Serial.print(pot1);
  Serial.print(",");
  Serial.print(pot2);
  Serial.print(",");  
  Serial.println(pot3);
  //esperar 100 ms
  delay(100); 
}
