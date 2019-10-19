// Entradadel valor depotenciometro 
int valor_potenciometro = 0;
void setup(){
  // Velocidad de la comunicación serial
  Serial.begin(9600);
}

void loop(){
  // Declaracion del PIN de entrada ánalogica del 
  // potenciometro
  valor_potenciometro = analogRead(A0);
  // Variable del puerto serial que se llama en MATLAB
  Serial.println(valor_potenciometro);
  delay(100);
}
