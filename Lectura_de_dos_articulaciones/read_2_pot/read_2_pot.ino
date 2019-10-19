int pot1 = 0;
int pot2 = 0;

void setup(){
  Serial.begin(9600);
}

void loop(){
  //Lectura de potenciómetros
  pot1 = analogRead(A0);
  pot2 = analogRead(A1);

  //Envío de información 
  Serial.print(pot1);
  Serial.print(",");
  Serial.println(pot2);

  //esperar 20 ms
  delay(20); 
}
