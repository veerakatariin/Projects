#include <LiquidCrystal.h>             // Sisällytetään LCD kirjasto
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); // ja output navat koodiin.


/* Kustomoidut grafiikat. */
      byte Scissors[] = {
        B10001,
        B10001,
        B10001,
        B11011,
        B01010,
        B00100,
        B11011,
        B11011
      };

      byte Rock[] = { // KPS pelin kivi ja LAB pelin timantit
        B00000,
        B00000,
        B00000,
        B01100,
        B01110,
        B11111,
        B11111,
        B11111
      };

      byte Block[] = { // Paperi KPS pelissä ja este LAB pelissä
        B11111,
        B11111,
        B11111,
        B11111,
        B11111,
        B11111,
        B11111,
        B11111
      };

      byte Character[] = { // LAB pelin hahmo
        B00000,
        B00000,
        B01110,
        B11011,
        B11110,
        B11111,
        B01110,
        B00000
      };

      byte Spaceship[] = { // Space Ace pelin alus
        B11110,
        B11000,
        B01000,
        B11111,
        B01000,
        B11000,
        B11110,
        B00000,
      };

      byte Missile[] = { // Space Ace pelin ohjus
        B00000,
        B10000,
        B01000,
        B11111,
        B01000,
        B10000,
        B00000,
        B00000,
      };

      byte Alien[] = { // Space Ace pelin vastus
        B00000,
        B00000,
        B00100,
        B01110,
        B10101,
        B01010,
        B10101,
        B10101,
      };

      byte Nothing[] = { // Tällä luodaan tyhjää tilaa
        B00000,
        B00000,
        B00000,
        B00000,
        B00000,
        B00000,
        B00000,
        B00000
      
      };

/* Global muuttujia labyrinttipeliin */

  int x;            //sijainti lcd näytöllä
  int y;            //sijainti lcd näytöllö
  int point = 0;    // pelissä kerättävät pisteet
  int result;       // tulos
  int win = 0;      // voitto
  int collide = 0;  // törmääminen

/* Muuttujat KPS-pelin pisteiden laskuun loopin ulkopuolella, jotta pysyvät muistissa */

  int score1 = 0;
  int score2 = 0;
  int first = 0;    // Jos peli käynnistetty ekan kerran näytetään pelin nimi

void setup() {

  // Määritetään painonapit
  pinMode(9, INPUT);
  pinMode(8, INPUT);
  pinMode(7, INPUT);
  pinMode(6, INPUT);
  
  lcd.begin(16, 2);

  // Sisällytetään kustomoidut grafiikat
  lcd.createChar(0, Scissors);
  lcd.createChar(1, Rock);
  lcd.createChar(2, Block);
  lcd.createChar(3, Character);
  lcd.createChar(4, Spaceship); 
  lcd.createChar(5, Missile);
  lcd.createChar(6, Alien);
  lcd.createChar(7, Nothing); 
}

void loop() {
  
  // Varmistetaan ettei näytölle jää edelliseltä loopilta mitään
  lcd.clear();
  
  /* VALIKON MUUTTUJAT */ 
  int peli1 = 0; // KPS loop
  int peli2 = 0; // LAB loop
  int peli3 = 0; // ACE loop
  int buttonHIGH = 0; // Valikkoa varten
  int kps = 0;
  int lab = 0;
  int ace = 0;

  /* VALIKKO */ 
  lcd.setCursor(0,0);
  lcd.print("KPS   LAB   ACE");  
  lcd.setCursor(0,1);
  lcd.print(" 1     2     3 ");
  
  // Pyörii niin pitkään, kunnes pelaaja painaa nappia
  do {
    kps = digitalRead(6);
    lab = digitalRead(9);
    ace = digitalRead(8);
      // Seurataan mitä nappia pelaaja painaa ja määritetään mikä peli aukaistaan.
      if (kps == HIGH) {
      buttonHIGH = 1;
      peli1 = 1;}
      else if (lab == HIGH) {
      buttonHIGH = 2;
      peli2 = 1;}
      else if (ace == HIGH) {
      buttonHIGH = 3;
      peli3 = 1;}   
  } while(buttonHIGH == 0) ;

  /* PELIT */
  
  // Pyyhitään valikko näkyvistä
  lcd.clear();
  delay(500);

  /* KIVI PAPERI SAKSET */

// Pyörii niin pitkään kunnes pelaaja päättää palata valikkoon  
while(peli1 == 1) {
 
  /* PELIN MUUTTUJAT */
  
  int btn1 = 0;                // Sakset nappi
  int btn2 = 0;                // Kivi nappi
  int btn3 = 0;                // Paperi nappi
  int start = 0;               // Aloitus nappi
  int back = 0;                // Paluu nappi
  
  int forward = 0;             // IF lause jonka sisällä itse peli on ei toteudu ilman tätä
  int chosen = 0;              // digitalRead valittu nappi
  int opponent = random(1, 4); // Tietokoneen satunnaisesti valittu ase
  int player = 0;              // Näytölle tulostettava grafiikka
  int ai = 0;                  // Näytölle tulostettava grafiikka
  
  // Looppeja varten
  int flag = 0;
  int flag2 = 0;
  int flag3 = 0;
  
  /* Jos pisteet ylittää luvun 9, nollataan tulokset */
  if (score1 > 9 || score2 > 9) {
    score1 = 0;
    score2 = 0;}
  
  /* Jos peli käynnistetty ekan kerran näytetään pelin nimi */
  
  first = first + 1;
  if(first == 1) {
    
    // Tulostetaan pelin nimi
    lcd.clear();
    lcd.setCursor(2, 0);
    lcd.print("KIVI, PAPERI");
    lcd.setCursor(4, 1);
    lcd.print("JA SAKSET");  
    delay(2000);
    lcd.clear();
  }
  
  /* Näytetään nimet vasemmassa ja pisteet oikeassa reunassa. */  
  
  lcd.setCursor(0,0);
  lcd.print("Player: ");
  lcd.setCursor(0,1);
  lcd.print("AI: ");  
  lcd.setCursor(15, 0);
  lcd.print(score1); 
  lcd.setCursor(15, 1);
  lcd.print(score2);
  
  /* Tämä looppi toistuu niin pitkään, kunnes pelaaja painaa
  joko start tai return nappia. Täten koodi ei mene läpi silloin kun pelaaja
  ei tee mitään. */
  
  while(flag == 0) {
    
    back = digitalRead(6);
    // Palataan takaisin valikkoon
    if (back == HIGH) {
    peli1 = 0;
    flag = 1;
    delay(1000); // ettei mene suoraan KPS peliin
    }
    
    start = digitalRead(7);
	// Aloitetaan peli
  	if (start == HIGH) {
    forward = 1;
    flag = 1;}
  }

  /* JOS PELI JATKUU */
  if (forward == 1) {
    
  /* Selvitetään minkä aseen tietokone nappia painamalla haluaa.
    Lasku 3 2 1 ja sitten näytetään vastustajan valinta,
  	jonka jälkeen odotetaan pelaajan valinta */
  
  	switch (opponent) {
  	case 1:
    ai = byte(0);
    break;
  	case 2:
    ai = byte(1);
    break;
  	case 3:
    ai = byte(2);
    break;}
  
  lcd.setCursor(4, 1);
  lcd.print("3");
  delay(500);  
  lcd.setCursor(4, 1);
  lcd.print("2");
  delay(500); 
  lcd.setCursor(4, 1);
  lcd.print("1");
  delay(500);  
  lcd.setCursor(4, 1);
  lcd.write(ai);
  
  /* Selvitetään minkä aseen pelaaja nappia painamalla haluaa. 
     Valinnalla on aikaraja, jos pelaaja ei valitse ennen kolmea 
     sekuntia, peli alkaa alusta ja tietokone saa pisteen. */
    
  for (int sec = 0; sec < 4; sec++) {

    switch (flag2) {
      
  	case 0:      
      btn1 = digitalRead(6);
      btn2 = digitalRead(9);
      btn3 = digitalRead(8);    
        if (btn1 == HIGH) {
        chosen = 1;}
        else if (btn2 == HIGH) {
        chosen = 2;}
        else if (btn3 == HIGH) {
        chosen = 3;}      
    lcd.setCursor(8, 0);
  	lcd.print("3");      
    flag2 = 1;
    break;
      
  	case 1:      
      btn1 = digitalRead(6);
      btn2 = digitalRead(9);
      btn3 = digitalRead(8);    
        if (btn1 == HIGH) {
        chosen = 1;}
        else if (btn2 == HIGH) {
        chosen = 2;}
        else if (btn3 == HIGH) {
        chosen = 3;}      
    lcd.setCursor(8, 0);
  	lcd.print("2");      
    flag2 = 2;
    break;
      
  	case 2:      
      btn1 = digitalRead(6);
      btn2 = digitalRead(9);
      btn3 = digitalRead(8);
        if (btn1 == HIGH) {
        chosen = 1;}
        else if (btn2 == HIGH) {
        chosen = 2;}
        else if (btn3 == HIGH) {
        chosen = 3;}      
    lcd.setCursor(8, 0);
  	lcd.print("1");      
    flag2 = 3;
    break;
      
    case 3:      
      btn1 = digitalRead(6);
      btn2 = digitalRead(9);
      btn3 = digitalRead(8);    
        if (btn1 == HIGH) {
        chosen = 1;}
        else if (btn2 == HIGH) {
        chosen = 2;}
        else if (btn3 == HIGH) {
        chosen = 3;}      
    lcd.setCursor(8, 0);
  	lcd.print("0");     
    flag2 = 0;
    break;}

    delay(1000);}    // Switch toistuu kolmesti eli kolme sekuntia
  
  	// Muutetaan pelaajan valinta graafiseksi
  	switch (chosen) {
  	case 1:
      player = byte(0);
      flag3 = 1;
    break;
  	case 2:
      player = byte(1);
      flag3 = 1;
    break;
  	case 3:
      player = byte(2);
      flag3 = 1;  
    break;
      
    // Jos pelaaja ei valinnut asetta ajoissa, tietokone voittaa ja peli loppuu
    case 0:
      lcd.setCursor(11, 1);
      lcd.print("Win!");
      score2 = score2 + 1;
    break;}
  
  // Määritellään kumpi voittaa kumman jos pelaaja valitsi aseen
  while (flag3 == 1) {

      // Näytetään pelaajan valinta näytöllä.
      lcd.setCursor(8, 0);
      lcd.write(player);
      
      if (chosen == 1 && opponent == 1) {
            lcd.setCursor(11, 0);
            lcd.print("Tie!");
            lcd.setCursor(11, 1);
            lcd.print("Tie!");
            flag3 = 0;}
       else if (chosen == 2 && opponent == 1) {
            lcd.setCursor(11, 0);
            lcd.print("Win!");
            score1 = score1 + 1;
            flag3 = 0;}
       else if (chosen == 3 && opponent == 1) {
            lcd.setCursor(11, 1);
            lcd.print("Win!");
            score2 = score2 + 1;
            flag3 = 0;}
       else if (chosen == 1 && opponent == 2) {
            lcd.setCursor(11, 1);
            lcd.print("Win!");
            score2 = score2 + 1;
            flag3 = 0;}
       else if (chosen == 2 && opponent == 2) {
            lcd.setCursor(11, 0);
            lcd.print("Tie!");
            lcd.setCursor(11, 1);
            lcd.print("Tie!");
            flag3 = 0;}
       else if (chosen == 3 && opponent == 2) {
            lcd.setCursor(11, 0);
            lcd.print("Win!");
            score1 = score1 + 1;
            flag3 = 0;}
       else if (chosen == 1 && opponent == 3) {
            lcd.setCursor(11, 0);
            lcd.print("Win!");
            score1 = score1 + 1;
            flag3 = 0;}
       else if (chosen == 2 && opponent == 3) {
            lcd.setCursor(11, 1);
            lcd.print("Win!");
            score2 = score2 + 1;
            flag3 = 0;}
       else if (chosen == 3 && opponent == 3) {
            lcd.setCursor(11, 0);
            lcd.print("Tie!");
            lcd.setCursor(11, 1);
            lcd.print("Tie!");
            flag3 = 0;}
}
  forward = 0; // Takaisin nollaksi että START nappi toimii taas
} 
  // Pyyhitään hetken päästä voitto/häviö ja aseet ilmoitus näytöltä
  delay(1500);
  lcd.setCursor(11, 0);
  lcd.print("    ");
  lcd.setCursor(11, 1);
  lcd.print("    ");
  lcd.setCursor(8, 0);
  lcd.print(" ");
  lcd.setCursor(4, 1);
  lcd.print(" ");

  /* PELI PALAA ALOITUSTILAAN */
}


  /* LABYRINTTI */

// Pyörii niin pitkään kunnes pelaaja päättää palata valikkoon
while(peli2 == 1){

  /* PELIN MUUTTUJAT */
  
  int characterx = 0;
  int charactery = 0;
  int game = 1;
  int a = 0;
          
  int start = 0;   // Aloitus nappi
  int back = 0;    // Paluu nappi
  int forward = 0; // IF lause jonka sisällä itse peli on ei toteudu ilman tätä
  
  // Looppia varten
  int flag = 0;
  
  // Nollataan aiemman pelikerran tulokset
  point = 0;
  win = 0;
  collide = 0;
  
  // Tulostetaan pelin nimi
  lcd.clear();
  lcd.setCursor(3, 0);
  lcd.print("LABYRINTTI");
  lcd.setCursor(1, 1);
  lcd.print("START / RETURN");
  
  /* Tämä looppi toistuu niin pitkään, kunnes pelaaja painaa
  joko start tai return nappia. Täten koodi ei mene läpi silloin kun pelaaja
  ei tee mitään. */
  
  while(flag == 0) {
       
    back = digitalRead(6);
    // Palataan takaisin valikkoon
    if (back == HIGH) {
    peli2 = 0;
    flag = 1;
    delay(1000); // Ettei mene valikosta suoraan KPS peliin
    }
    
    start = digitalRead(7);
	// Aloitetaan peli
  	if (start == HIGH) {
    forward = 1;
    flag = 1;}
  }
  
  /* JOS PELI JATKUU */
  if (forward == 1) {
    
  // Pelin aloitus grafiikat  
  lcd.home();
  lcd.setCursor(0,0);
  lcd.print("Starting game...");
  delay(2500);
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Get through");
  lcd.setCursor(0,1);
  lcd.print("The maze");
  delay(2500);
  lcd.clear(); 
    
  //Tulostettu pelissä näkyvä labyrintti ja siellä olevat esteet
  lcd.setCursor(0,0);
  lcd.write(byte(2));
  lcd.setCursor(1,0);
  lcd.write(byte(2));
  lcd.setCursor(6,0);
  lcd.write(byte(2));
  lcd.setCursor(10,0);
  lcd.write(byte(2));
  lcd.setCursor(11,0);
  lcd.write(byte(2));
  lcd.setCursor(14,0);

  lcd.setCursor(3,1);
  lcd.write(byte(2));
  lcd.write((1));
  lcd.setCursor(8,1);
  lcd.write(byte(2));
  lcd.setCursor(13,0);
  lcd.write(byte(2));
    
  lcd.setCursor(2,0);
  lcd.write(byte(1));
  lcd.setCursor(3,0);
  lcd.write(byte(1));
  lcd.setCursor(4,0);
  lcd.write(byte(1));
  lcd.setCursor(5,0);
  lcd.write(byte(1));
  lcd.setCursor(7,0);
  lcd.write(byte(1));
  lcd.setCursor(8,0);
  lcd.write(byte(1));
  lcd.setCursor(9,0);
  lcd.write(byte(1));
  lcd.setCursor(12,0);
  lcd.write(byte(1));
  
  lcd.setCursor(6,1);
  lcd.write(byte(1));
  lcd.setCursor(7,1);
  lcd.write(byte(1));
  lcd.setCursor(9,1);
  lcd.write(byte(1));
  lcd.setCursor(12,1);
  
  // Toistaa peliä niin pitkään kunnes pelaaja häviää tai voittaa
  do {
    
    int left = digitalRead(7);
    int down = digitalRead(9);
    int right = digitalRead(8);
    int up = digitalRead(6);
     
    //Tulostetaan näytölle pelin hahmo
    lcd.setCursor(characterx,charactery);
    lcd.write(byte(3));
      
    //Sijainti törmäysten ja voiton tarkistamiseen
    x = characterx;
    y = charactery;
     
    
    /* NAPIT JA OHJAUS */
    if (left or down or right or up == HIGH){
        
      /* Luetaan mitä nappia painetaan. Case 1-4:ssä
      on määritelty mihin suuntaan liikuntaan, 
      riippuen mitä nappia painetaan. */
      
      if (left == HIGH) {
      a = 1;
      }
      else if (down == HIGH) {
      a = 2;
      }
      else if (right == HIGH) {
      a = 3;
      }
      else if (up == HIGH){
      a = 4;
      }
      
      delay(100);
      
      switch(a){
      case 1:
         lcd.setCursor(characterx,charactery);
         lcd.write(byte(7));
         characterx = characterx -1;
         break;
                 
      case 2:
         lcd.setCursor(characterx,charactery);
         lcd.write(byte(7));
         charactery = charactery - 1; 
         break;
             
         case 3:
         lcd.setCursor(characterx,charactery);
         lcd.write(byte(7));
         characterx = characterx + 1;
         break;
            
      case 4:
         lcd.setCursor(characterx,charactery);
         lcd.write(byte(7));
         charactery = charactery + 1; 
         break; }
              
       // Tarkistaa onko pisteitä kertynyt kivien keräämisestä. 
       Points();
       } 
    
       // Tarkistetaan päästiinkö pelissä labyrintin loppuun asti 
       Winner();
       if (win == 1){
        result = 1;
        game = 0; }
       
       // Tarkistetaan onko törmätty labyrintin esteisiin
       Collision();
       if (collide == 1){
        result = 2;
        game = 0; }
         
     } while (game == 1);
  

  /* Törmätessä esteeseen tai labyrintin reuniin peli loppuu 
  Näytölle tulostuu game over ja pelissä saadut pisteet */
    
  if (result == 2){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("   GAME OVER");
  lcd.setCursor(0,-1);
  lcd.print("   POINTS:");
  lcd.setCursor(12,-1);
  lcd.print(point);
  delay(3000);
  }
  
  /* Peli voitetaan kulkemalla labyrintin oikeaan päätyyn
  Näytölle tulostuu you win ja kerätyt pisteet */
    
  if (result == 1){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("   YOU WIN!");
  lcd.setCursor(0,-1);
  lcd.print("   POINTS:");
  lcd.setCursor(12,-1);
  lcd.print(point);
  delay(3000);
  }
 }
  forward = 0; // Takaisin nollaksi että START nappi toimii taas
}

  
  /* SPACE ACE */
  
// Pyörii niin pitkään kunnes pelaaja päättää palata valikkoon
while(peli3 == 1){
   
  /* MUUTTUJAT */ 
  
  int missiler = 0;    // Ohjus rivi
  int missilec = 0;    // Ohjus palkki
  int alienr = 0;      // Vihollisen rivi
  int alienc = 0;      // Vihollisen palkki 
  int rockr = 0;       // Asteroidi rivi
  int rockc = 0;       // Asteroidi palkki  
  int player = 0;      // Pelaajan rivi

  int asteroid = 0;    // Asteroidi
  int fire = 0;        // Ampuminen
  int enemy = 0;       // Vihollinen
  int life = 0;        // Elämä
  int points = 0;      // Alienin tapot
  
  int start = 0;       // Aloitus nappi
  int back = 0;        // Paluu nappi
  int forward = 0;     // IF lause jonka sisällä itse peli on ei toteudu ilman tätä
  
  // Looppeja varten
  int flag = 0;
  int flag2 = 0;
  int flag3 = 0;

  // Tyhjentää näytön
  delay (500);
  lcd.clear();
  
  // Tulostetaan pelin nimi
  lcd.setCursor (5,0);
  lcd.print ("SPACE");
  lcd.setCursor (6,1);
  lcd.print("ACE");
  
  delay(2000);
  lcd.clear();
  
  lcd.setCursor (3,0);
  lcd.print ("PRESS FIRE");
  lcd.setCursor (4,1);
  lcd.print("TO START");
    
  /* Tämä looppi toistuu niin pitkään, kunnes pelaaja painaa
  joko start tai return nappia. Täten koodi ei mene läpi silloin kun pelaaja
  ei tee mitään. */
  
  while(flag == 0) {
       
    back = digitalRead(6);
    // Palataan takaisin valikkoon
    if (back == HIGH) {
    peli3 = 0;
    flag = 1;}
    
    start = digitalRead(7);
	// Aloitetaan peli
  	if (start == HIGH) {
    forward = 1;
    flag = 1;}
  }
  
  /* JOS PELI JATKUU */
  if (forward == 1) {

  delay(500);
  lcd.clear();

  // Peli alkaa lähtölaskennalla.
  lcd.setCursor (4,0);
  lcd.print ("READY...");
  
  delay(1000);
  lcd.clear();

  lcd.setCursor(5,0);
  lcd.print ("SET...");
  
  delay(1000);
  lcd.clear();

  lcd.setCursor(5,0);
  lcd.print ("FLY!!!");

  delay(1000);
  lcd.clear();
  
  flag2 = 1;

  /* Grafiikat ilmestyy näytölle */
    
  do {
    
  // Alienin ja asteroidin nopeus.
  delay(500);
    
  flag3 = 0;
      
  // Ohjus lähtee samalta riviltä kuin pelaaja.  
  missiler = player;
  
  // Pelaaja ensimmäiselle riville.
  lcd.setCursor(0,player);
  lcd.write(4);
  
  /* AMPUMINEN */
    
  if(digitalRead(7) == LOW){
  
    fire = 1;

    lcd.setCursor(missilec,missiler);
    lcd.write(7);

    missilec = missilec + 1;
    lcd.setCursor(missilec,missiler);
    lcd.write(5);
  }
  
  /* Kun painaa napin pohjaan pelaaja vaihtaa riviä 
  ja kun päästää napin pohjasta pelaaja palaa takaisin. */
    
  if(digitalRead(9) == HIGH){
  
    player = 1;
    lcd.setCursor(0,0);
    lcd.write(7);
  
 }
    
  else {
    
    player = 0;
    
    lcd.setCursor(0,1);
    lcd.write(7);
  }
  
  /* Oikeaan yläkulmaan lasketaan pisteet. 
  Pisteen saa kun osuu alieniin. */
    
  lcd.setCursor(14,0);
  lcd.print("P");
  
  if(points > 0){     
    lcd.print(points);
  }
  
  // Pisteinä näkyy 0 ennenkuin pelaaja saa pisteitä.
  else(points = 0);{
    lcd.print("0");
  }
  
  // Pelaaja ensimmäiselle riville.
  lcd.setCursor(0,player);
  lcd.write(4);
 
  if(enemy == 0 && asteroid == 0){
    
    alienr = random(0,101); // Arvotaan kummalle riville vihollinen ilmestyy.  
    rockr = random(0,101);  // Arvotaan asteroidin rivi.
  
    if  (alienr<50 && rockr<50){
      alienr = 0;
      rockr = 0;
    }

    else{
      alienr = 1;
      rockr = 1;
    }
    
  alienc = 14;
  rockc = 14;
 
  // Asteroidi ilmestyy
  lcd.setCursor(rockc,rockr);
  lcd.write(1);
  asteroid = 1;

  // Vihollinen ilmestyy
  lcd.setCursor(alienc,alienr);
  lcd.write(6);
  enemy = 1;          
}

  // Vihollinen tai asteroidi saavuttaa viimeisin pykälän ja peli on ohi.
  else if (rockc <= 1 || alienc == 1){

    life = life - 1;

    alienc = 14;
    rockc = 14;

    lcd.clear();
    delay(500);
    lcd.clear(); 
}
    
  else{
    
    // Vihollinen liikkuu yhden pykälän eteenpäin vasemalle.
    lcd.setCursor(alienc,alienr);
    lcd.write (7);

    alienc = alienc - 1;    
    lcd.setCursor(alienc,alienr);
    lcd.write(6);

    //Asteroidi liikkuu kaksi pykälää eteenpäin vasemalle.
    lcd.setCursor(rockc,rockr);
    lcd.write (7);

    rockc = rockc - 2;    
    lcd.setCursor(rockc,rockr);
    lcd.write(1);
}
  
  if(missilec >= alienc && missiler == alienr){

     missilec = 0;
     alienc = 14;
     alienr = random(0,2);
     points = points + 1;
     lcd.clear();
  }
  
  if(missilec >= rockc && missiler == rockr){

     missilec = 0;
     rockc = 14;
     rockr = random(0,2);
     lcd.clear();
  }
      
  // Peli voittaa
  if(points==10){
      
    lcd.clear();
    delay(1000);

    alienc = 14;
    life = 0;
    missilec = 0;
    rockc = 14;
    points = 0;

    lcd.setCursor(5,0);
    lcd.print("WINNER");
    lcd.setCursor (5,1);
    lcd.print ("WINNER");

    delay (3000);
    lcd.clear();
    delay(500);

    lcd.setCursor(6,0);
    lcd.print("FLY");
    lcd.setCursor(5,1);
    lcd.print("AGAIN?");  
    delay(1000);

  /* Pelin voi aloittaa uudestaan painamalla ampumispainiketta. */
    
  while(flag3 == 0) {
       
    back = digitalRead(6);
    // Palataan takaisin valikkoon
    if (back == HIGH) {
    flag2 = 0;
    flag3 = 1;
    delay(1000); // ettei mene suoraan KPS peliin
    }
    
    start = digitalRead(7);
	// Aloitetaan peli
  	if (start == HIGH) {
    flag3 = 1;
    lcd.clear();}
  }  
}
  
      
  // Vihollinen tai kivi saavuttaa viimeisin rivin ja peli on ohi.
  if(life<0) {

    lcd.clear();

    alienc = 14;
    life = 0;
    missilec = 0;
    rockc = 14;
    points = 0;

    lcd.setCursor(6,0);
    lcd.print("GAME");
    lcd.setCursor (6,1);
    lcd.print ("OVER");

    delay (2000);
    lcd.clear();

    lcd.setCursor(2,0);
    lcd.print("BETTER LUCK");
    lcd.setCursor (3,1);
    lcd.print ("NEXT TIME");

    delay (2000);
    lcd.clear();

    lcd.setCursor(6,0);
    lcd.print("FLY");
    lcd.setCursor(5,1);
    lcd.print("AGAIN?");  
    delay(1000);
  
  /* Pelin voi aloittaa uudestaan painamalla ampumispainiketta. */

  while(flag3 == 0) {
       
    back = digitalRead(6);
    // Palataan takaisin valikkoon
    if (back == HIGH) {
    flag2 = 0;
    flag3 = 1;
    peli3 = 0;
    delay(1000); // ettei mene suoraan KPS peliin
    }
    
    start = digitalRead(7);
	// Aloitetaan peli
  	if (start == HIGH) {
    flag3 = 1;
    lcd.clear();}
  }  
}
    } while(flag2 == 1);
}
  forward = 0; // Takaisin nollaksi että START nappi toimii taas
}
}

/* VOID LOOP LOPPUU */




/* FUNKTIOITA LABYRINTTIPELIIN */


/* Labyrintin loppuun pääseminen on määritelty voitoksi */
void Winner(){
  
  if (x==15&&(y==0||y==-1)){
    win=1;
  }   
}

/* Labyrintin reunat ja esteet on määritelty niin, että
niiden kohdalle liikkuessa hävitään peli */
void Collision(){
  
  if (y == 0&&(x == 1||x ==6||x ==10||x ==11||x ==13)){
    collide = 1;}
  if (y==-1&&(x == 3||x ==8)){
    collide = 1;}
  if (y ==-2&&(x==0||x ==1||x ==2||x==3||x==4||x==5||x==6||x==7||x==8||x==9||x==10||x==11||x==12||x==13||x==14)){
    collide = 1;}
  if (y==1&&(x==0||x ==1||x ==2||x==3||x==4||x==5||x==6||x==7||x==8||x==9||x==10||x==11||x==12||x==13||x==14)){
    collide = 1;}
  if (x==-1&&(y==0||y==-1)){
    collide=1;}
}

/* Lasketaan pisteet kivien keräämisestä */
void Points(){
  
  int p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11 = 1;
  if (p0=1&&y==0&&x==2){point+=1;p0=0;}
  if (p1=1&&y==0&&x==3){point+=1;p1=0;}
  if (p2=1&&y==0&&x==4){point+=1;p2=0;}
  if (p3=1&&y==0&&x==5){point+=1;p3=0;}
  if (p4=1&&y==0&&x==7){point+=1;p4=0;}
  if (p5=1&&y==0&&x==8){point+=1;p5=0;}
  if (p6=1&&y==0&&x==9){point+=1;p6=0;}
  if (p7=1&&y==0&&x==12){point+=1;p7=0;}
  if (p8=1&&y==-1&&x==4){point+=1;p8=0;}
  if (p9=1&&y==-1&&x==6){point+=1;p9=0;}
  if (p10=1&&y==-1&&x==7){point+=1;p10=0;}
  if (p11=1&&y==-1&&x==9){point+=1;p11=0;}
}
