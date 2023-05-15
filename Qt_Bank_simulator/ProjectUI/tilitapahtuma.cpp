#include "tilitapahtuma.h"
#include "ui_tilitapahtuma.h"
#include "menu.h"

//ikkunan avautuessa käyttäjälle näytetään tilin omistajan tiedot, 10 viimeistä tilitapahtumaa ja tilin saldo
//eteen ja taaksepäin näppäimillä voidaan katsella lisää tilitapahtumia
//jos ikkunassa ei tehdä mitään 10 sekuntiin, palataan menuun automaattisesti
//sulje painikkeella palataan menuun

Tilitapahtuma::Tilitapahtuma(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Tilitapahtuma)
{
    ui->setupUi(this);
    manager = new DLLRestApi;

    QString id = "1";
    QString actionid = "3";
    manager->getActions(cardid);
    manager->getCustomer(cardid);
    manager->getSaldo(cardid);

    connect(manager, SIGNAL(customerToExe(QString)),
            this, SLOT(getCustomer(QString)));
    connect(manager, SIGNAL(saldoToExe(QString)),
            this, SLOT(getSaldo(QString)));

    connect(manager, SIGNAL(actionsToExe(QString)),
            this, SLOT(getActions(QString)));

    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_tilitakaisin_clicked()));
   // timer->start(10000);


    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode
}

Tilitapahtuma::~Tilitapahtuma()
{
    delete ui;
    delete timer;
    timer = nullptr;
    delete manager;
    manager = nullptr;
}

//tuodaan kortin id menusta
void Tilitapahtuma::getcardid(QString id){
    cardid = id;
}

//sulje painike jolla päästään takaisin menuun
void Tilitapahtuma::on_pushButton_tilitakaisin_clicked()
{
    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
}

//asetetaan saldo, asiakkaan tiedot ja tilitapahtumat näkyviin näytölle
void Tilitapahtuma::getSaldo(QString saldo){
    qDebug() << saldo;
    ui->lineEdit->setText(saldo);
}


void Tilitapahtuma::getActions(QString actions){
    qDebug() << actions +"saaapu";
    ui->listWidget->addItem(actions);
}

void Tilitapahtuma::getCustomer(QString customer){
    qDebug() << customer;
    ui->lineEdit_3->setText(customer);
}


void Tilitapahtuma::on_pushButton_2_clicked()
{
    //mennään edellisiin tilitapahtumiin
}

void Tilitapahtuma::on_pushButton_clicked()
{
    //mennään seuraaviin tilitapahtumiin
}
