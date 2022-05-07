#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <Arduino_JSON.h>
#include <WiFiClient.h>

WiFiClient wifiClient;
const char* ssid = "TROJON";
const char* password = "sk6@1998";
bool s1;
bool s2;
bool s3;
String jsonBuffer;
String serverPath = "http://192.168.1.6:5000/";
void setup() {
  Serial.begin(115200);

  pinMode(D5, OUTPUT);
  pinMode(D6, OUTPUT);
  pinMode(D7, OUTPUT);
  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());

}

void loop() {
  // put your main code here, to run repeatedly:
  HTTPClient http;    //Declare object of class HTTPClient
  if(WiFi.status()== WL_CONNECTED){
      
      

    Serial.print("Request Link:");
    Serial.println(serverPath);
    
    http.begin(wifiClient,"http://192.168.1.6:5000");     //Specify request destination
    
    int httpCode = http.GET();            //Send the request
    String payload = http.getString();    //Get the response payload from server
  
    Serial.print("Response Code:"); //200 is OK
    Serial.println(httpCode);   //Print HTTP return code
  
    Serial.print("Returned data from Server:");
    Serial.println(payload);    //Print request response payload
    JSONVar myObject = JSON.parse(payload);
    Serial.println(myObject["data"]["switch2"]);
    s1 = myObject["data"]["switch1"];
    s2 = myObject["data"]["switch2"];
    s3 = myObject["data"]["switch3"];
    if(s1 == true){
      digitalWrite(D5,LOW);
    }
    else{
      digitalWrite(D5,HIGH);
    }
    delay(100);
    if(s2 == true){
      digitalWrite(D6,LOW);
    }
    else{
      digitalWrite(D6,HIGH);
    }
    delay(100);
    if(s3 == true){
      digitalWrite(D7,LOW);
    }
    else{
      digitalWrite(D7,HIGH);
    }
    delay(100);
    
  }
}
