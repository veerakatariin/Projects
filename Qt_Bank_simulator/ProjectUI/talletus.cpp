#include "talletus.h"
#include "ui_talletus.h"
#include "menu.h"
#include "talletussuccess.h"

//ikkunan avautuessa käyttäjälle näytetään asiakkaan tiedot ja saldo
//asiakas voi valita näppäimistöltä kuinka paljon rahaa hän haluaa tallettaa
//talletuksen jälkeen ilmoitetaan onnistumisesta ja näytetään uusi saldo
//kun painetaan takaisin nappulaa, talletusikkuna sulkeutuu ja menu avautuu uudelleen

Talletus::Talletus(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Talletus)
{
    ui->setupUi(this);

    enkine = new engine;

    manager = new DLLRestApi;
    manager->getSaldo(cardid);
    manager->getCustomer(cardid);

    connect(manager, SIGNAL(depositToExe()),
            this, SLOT(depositFromEngine()));
    connect(manager, SIGNAL(saldoToExe(QString)),
            this, SLOT(saldoFromInterface(QString)));
    connect(manager, SIGNAL(customerToExe(QString)),
            this, SLOT(customerFromInterface(QString)));


    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_clicked()));
   // timer->start(10000);


    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode

}

Talletus::~Talletus()
{
    delete ui;
    delete enkine;
    enkine = nullptr;
    delete manager;
    manager = nullptr;
    delete timer;
    timer = nullptr;
}

//tuodaan kortin idnumero menusta
void Talletus::getcardid(QString id){
    cardid = id;
}

//sulje painikkeella päästään takaisin menuun
void Talletus::on_pushButton_clicked(){
    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
}

//talletuksen onnistuessa avataan uusi ikkuna, jossa ilmoitetaan siitä ja näytetään uusi saldo
void Talletus::depositFromEngine(){
    this->close();
    talletusSuccess success;
    success.setModal(true);
    success.exec();
}

//asetetaan tilin saldo ja asiakkaan tiedot näytölle
void Talletus::saldoFromInterface(QString saldo){
    ui->lineEdit_saldo->setText(saldo);
}

void Talletus::customerFromInterface(QString customer){
    ui->lineEdit_customer->setText(customer);

}

//nostopainike, jolla tehdään talletuspyyntö
void Talletus::on_pushButton_8_clicked(){
    manager->getNewAction(amount,cardid);
    //timer->start(10000);
}

//painikkeet talletettavan summan valitsemiseen
void Talletus::on_pushButton_100_clicked(){
    amount = "100";
   // timer->start(10000);
}

void Talletus::on_pushButton_40_clicked(){
    amount = "40";
   // timer->start(10000);
}

void Talletus::on_pushButton_200_clicked(){
    amount = "200";
   // timer->start(10000);
}

void Talletus::on_pushButton_60_clicked(){
    amount = "60";
   // timer->start(10000);
}

void Talletus::on_pushButton_600_clicked(){
    amount = "600";
    //timer->start(10000);
}

void Talletus::on_pushButton_20_clicked(){
    amount = "20";
    //timer->start(10000);
}

