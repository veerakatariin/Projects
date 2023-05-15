#include "saldo.h"
#include "dllrestapi.h"
#include "ui_saldo.h"
#include <QObject>
#include "menu.h"

//ikkunan avattua näytetään asiakkaan tiedot, 10 viimeistä tilitapahtumaa ja tilin saldo
//jos ikkunassa ei tehdä mitään, palataan automaattisesti takaisin menuun
//sulje painikkeella palataan menuun

Saldo::Saldo(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Saldo)
{
    ui->setupUi(this);

    manager = new DLLRestApi;
    idsender = new Menu;

    manager->getSaldo(cardid);
    manager->getCustomer(cardid);
    manager->getActions(cardid);

    connect(manager, SIGNAL(customerToExe(QString)),
           this, SLOT(getCustomer(QString)));
    connect(manager, SIGNAL(actionsToExe(QString)),
           this, SLOT(getActions(QString)));
    connect(manager, SIGNAL(saldoToExe(QString)),
           this, SLOT(getSaldo(QString)));

    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_clicked()));
    //timer->start(10000);


    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode

}

Saldo::~Saldo(){

    delete ui;
    delete manager;
    manager = nullptr;
    delete enkine;
    enkine = nullptr;
    delete timer;
    timer = nullptr;
    delete idsender;
    idsender = nullptr;
}

//tuodaan kortin id menusta
void Saldo::getcardid(QString id){
    cardid = id;
}

//asetetaan tiedot lineEditeihin näkyville
void Saldo::getSaldo(QString saldo){

    ui->lineEdit_saldo->setText(saldo);
}

void Saldo::getCustomer(QString customer){

    ui->lineEdit_asiakas->setText(customer);
}

void Saldo::getActions(QString actions){

    ui->lineEdit_tilitapahtumat->setText(actions);
}

//sulje nappula josta pääsee takaisin menuun
void Saldo::on_pushButton_clicked(){
    this->close();

    Menu kir;
    kir.setModal(true);
    kir.exec();

}
