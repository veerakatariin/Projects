#include "mainwindow.h"
#include <QApplication>

//avataan mainwindow ikkuna, jossa odotetaan kortinlukua
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}



//kortin lukitus mainwindowiin

//mainwindowiin getcard funktioon pitäis laittaa slot dllrestapin engineen jotta id saadaan
//kortinnumerolla tai tehdä yksinkertainen huonompi toteutus

//tilitapahtumat pitää saada näkymään oikein saldossa ja tilitapahtumissa
//ei oo tarpeeksi rahaa ilmoituksen tuleminen siirtoon pitäis saaha sulkeutumaan 10 sekunnin päästä

//siirto talletus ja nosto ei toimi muutaku 1 tilille
//id pitäs laittaa get ja post käskyihin urliin muuttujana


//ei pääse takasin aloituskäyttöliittymään kirjaudu ulos jututsta (Nyt pääsee, mutta ei jos on
                                                     // käynyt jossain muussa liittymässä.
                                                     // Ongelma liittyy tod. näk setModal(true)-juttuun.
                                                     // Onko sitä pakko käyttää? Vaihdoin mainiin ja sisään-
                                                     // kirjautumiseen sen sijalle toisen tavan.)

//postmanyactionslot pitäis saada näyttään kaikki tilitapahtumat tai poistaa


//mainwindowiin getcard funktioon pitäis laittaa slot dllrestapin engineen jotta id saadaan
//kortinnumerolla tai tehdä yksinkertainen huonompi toteutus

//dllserialportin pitää hakea id mainwindowin sijaan


