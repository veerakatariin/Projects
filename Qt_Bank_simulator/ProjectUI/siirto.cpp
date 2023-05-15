#include "siirto.h"
#include "ui_siirto.h"
#include "menu.h"
#include "addrecipient.h"

//ikkunassa näytetään tilin omistajan tiedot ja tilin saldo
//näytöllä on näppäimistö, jolla voidaan syöttää vastaanottajan tilinumero
//jos tilillä ei riitä kate siirtoo, siitä tulee ilmoitus käyttäjälle
//jos mitään ei tehdä 30 sekuntiin, palataan automaattisesti menuun
//sulje painikkeella päästään pääkäyttöliittymään

Siirto::Siirto(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Siirto)
{
    ui->setupUi(this);
    manager = new DLLRestApi;
    move = new addRecipient;

    manager->getSaldo(cardid);

    connect(manager, SIGNAL(customerToExe(QString)),
           this, SLOT(getCustomer(QString)));
    connect(manager, SIGNAL(saldoToExe(QString)),
           this, SLOT(getSaldo(QString)));

    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_clicked()));
   // timer->start(30000);


    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode
}

Siirto::~Siirto(){
    delete ui;
    delete timer;
    timer = nullptr;
    delete move;
    move = nullptr;
    delete manager;
    manager = nullptr;

}

void Siirto::getcardid(QString id){
    cardid = id;
}

//sulje painike jolla päästään takaisin menuun
void Siirto::on_pushButton_clicked()
{
    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
}

//laitetaan tilin saldo ja asiakkaan tiedot näkyville lineediteihin
void Siirto::getSaldo(QString saldo){
    ui->lineEdit_saljo->setText(saldo);
}

void Siirto::getCustomer(QString customer){
    ui->lineEdit_omistaja->setText(customer);
}

//painikkeet joilla valitaan tilisiirron summa
void Siirto::on_pushButton_2_clicked(){

    number = "1";
    accountnumber = accountnumber+number;
    ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_3_clicked(){
   number = "2";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
   // timer->start(30000);

}

void Siirto::on_pushButton_4_clicked(){
   number = "3";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_5_clicked(){
   number = "4";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_6_clicked(){
   number = "5";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}


void Siirto::on_pushButton_7_clicked(){
   number = "6";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_8_clicked(){
   number = "7";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_9_clicked(){
   number = "8";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_10_clicked(){
   number = "9";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_11_clicked(){
   number = "F";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

void Siirto::on_pushButton_12_clicked(){
   number = "I";
   accountnumber = accountnumber+number;
   ui->lineEdit_number->setText(accountnumber);
    //timer->start(30000);
}

//pyyhi painike
void Siirto::on_pushButton_13_clicked(){
    accountnumber = nullptr;
    ui->lineEdit_number->setText(accountnumber);
    ui->lineEdit->setText(" ");
     //timer->start(30000);

}

void Siirto::on_pushButton_15_clicked(){
    number = "0";
    accountnumber = accountnumber+number;
    ui->lineEdit_number->setText(accountnumber);
     //timer->start(30000);
}

//jatka painikkeeesta päästään uuteen ikkunaan, jos tilinumero tunnistetaan tässä pankkijärjestelmässä olevaksi
//jos tilinumeroa ei tunnisteta, siitä annetaan virheilmoitus
void Siirto::on_pushButton_14_clicked(){
     //timer->start(30000);

        QString card1 = "FI501234";
        QString card2 = "FI505678";
        QString card3 = "FI509874";
        move = new addRecipient;

        if(accountnumber == card1){

            recipientid = "1";
            move->getRecipient(recipientid);

            this->close();
            addRecipient continu;
            continu.setModal(true);
            continu.exec();
        }
        else if(accountnumber == card3){

            recipientid = "3";
            move->getRecipient(recipientid);

            this->close();
            addRecipient continu;
            continu.setModal(true);
            continu.exec();
        }
        else if(accountnumber == card2){

            recipientid = "2";
            move->getRecipient(recipientid);

            this->close();
            addRecipient continu;
            continu.setModal(true);
            continu.exec();
        }
        else{
            ui->lineEdit->setText("tilinumero on virheellinen");
            accountnumber = nullptr;

        }
}
