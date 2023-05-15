#include "nosto.h"
#include "ui_nosto.h"
#include "menu.h"
#include "nostosuccess.h"
#include "nostofail.h"

//käyttöliittymässä on näppäimistö, joilla voidaan valita talletettava rahasumma
//summan valittua painetaan nappia talleta
//talletuksen jälkeen avautuu uusi ikkuna, jossa kerrotaan talletuksen onnistuminen ja päivitetty saldo
//jos ikkunassa ei tehdä mitään 10 sekuntiin, palataan automaattisesti menuun
//sulje painikkeella päästään menuun

Nosto::Nosto(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Nosto)
{
    ui->setupUi(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_clicked()));
    timer->start(10000);

    manager = new DLLRestApi;

    manager->getSaldo(cardid);
    manager->getCustomer(cardid);

    connect(manager, SIGNAL(saldoToExe(QString)),
            this, SLOT(getSaldo(QString)));
    connect(manager, SIGNAL(customerToExe(QString)),
            this, SLOT(getCustomer(QString)));
    connect(manager, SIGNAL(withdrawalToExe()),
            this, SLOT(getWithdrawal()));


    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode

}

Nosto::~Nosto()
{
    delete ui;
    delete manager;
    manager = nullptr;
    delete timer;
    timer = nullptr;

}

//tuodaan cardid menusta
void Nosto::getcardid(QString id){
    cardid = id;
}

//sulje nappula, jota painamalla pääsee menuun
void Nosto::on_pushButton_clicked(){

    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
    delete timer;
}

//asetetaan tiedot näytölle lineediteihin
void Nosto::getSaldo(QString saldo){

    ui->lineEdit_2->setText(saldo);
    savesaldo = saldo;
}

void Nosto::getCustomer(QString customer){

    ui->lineEdit_3->setText(customer);
}

//napit joilla voidaan valita noston määrä
void Nosto::on_pushButton_20_clicked(){
    amount = "20";
   timer->start(10000);
}

void Nosto::on_pushButton_100_clicked(){
    amount = "100";
    timer->start(10000);
}

void Nosto::on_pushButton_40_clicked(){
    amount = "40";
    timer->start(10000);
}

void Nosto::on_pushButton_200_clicked(){
    amount = "200";
    timer->start(10000);
}

void Nosto::on_pushButton_60_clicked(){
    amount = "60";
    //timer->start(10000);
}

void Nosto::on_pushButton_600_clicked(){
    amount = "600";
    timer->start(10000);
}

//nosto nappia painamalla mennään funktioon, joka lisää tietokantaan otto actionin
//jos tilillä ei ole riittävästi rahaa, avautuu uusi ikkuna jossa ilmoitetaan tästä
void Nosto::on_pushButton_nosto_clicked(){
    int amountInt = amount.toInt();
    int savesaldoInt = savesaldo.toInt();
    timer->start(10000);

    if(amountInt <= savesaldoInt){

        QString id = "1";
        QString sendAmount = "-"+amount;

        manager->getNewWithdrawal(sendAmount, id);
    }
    else if(amountInt > savesaldoInt){

         this->close();
         nostofail fail;
         fail.setModal(true);
         fail.exec();
    }
}

//noston onnistuessa avautuu uusi ikkuna jossa näkyy päivitetty saldo
void Nosto::getWithdrawal(){

    this->close();
    nostosuccess nosto;
    nosto.setModal(true);
    nosto.exec();

}
