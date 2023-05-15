#include "addrecipient.h"
#include "ui_addrecipient.h"
#include <QDebug>
#include "menu.h"

addRecipient::addRecipient(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::addRecipient)
{
    ui->setupUi(this);

    manager = new DLLRestApi;
    manager->getSaldo(cardid);

    connect(manager, SIGNAL(saldoToExe(QString)),
           this, SLOT(getSaldo(QString)));
    connect(manager, SIGNAL(withdrawalToExe()),
           this, SLOT(getWithdrawal()));
    connect(manager, SIGNAL(depositToExe()),
            this, SLOT(getActions()));
    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_sulje_clicked()));
    //timer->start(30000);

}

addRecipient::~addRecipient(){
    delete ui;
    delete manager;
    manager = nullptr;
}

//tuodaan kortin id menusta
void addRecipient::getcardid(QString id){
    cardid = id;
}

//lisätään vastaanottajan idnumero muuttujaan recipient
void addRecipient::getRecipient(QString recipientid){
   recipient = recipientid;
   qDebug() << "mo" + recipientid;
}

//otto signaalin takaisintulo signaali
void addRecipient::getActions(){
    qDebug() << "moii";
}

//asetetaan saldo eri muuttujaan
void addRecipient::getSaldo(QString saldo){
    savesaldo = saldo;
}

//signaalin tultua ilmoitetaan onnistuneesta siirrosta
void addRecipient::getWithdrawal(){
    ui->lineEdit->setText("siirto onnistui");
}

//siirto nappia painattaessa tehdään pyynnöt vähentää rahaa lähettäjän tililtä
//ja lisätä rahaa vastaanottajan tilille
//jos tilillä ei ole tarpeeksi rahaa, tästä tulee ilmoitus
void addRecipient::on_pushButton_siirr_clicked(){
    timer->start(30000);
    QString deposit = number;
    sendNumber = "-"+number;
    int num = sendNumber.toInt();
    int saldoo = savesaldo.toInt();

    if(saldoo>= num){

        QString id = "1";
        manager->getNewWithdrawal(sendNumber, id);
        manager->getNewAction(deposit, recipient);
    }
    else{

        ui->lineEdit_2->setText("tilillä ei rahaa");
    }
}

void addRecipient::on_pushButton_sulje_clicked(){
    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
}

void addRecipient::on_pushButton_clicked(){
    number = "20";
    //timer->start(30000);
}

void addRecipient::on_pushButton_2_clicked(){
     number = "40";
     //timer->start(30000);
}

void addRecipient::on_pushButton_3_clicked(){
     number = "60";
     //timer->start(30000);
}

void addRecipient::on_pushButton_4_clicked(){
     number = "100";
     //timer->start(30000);
}

void addRecipient::on_pushButton_5_clicked(){
     number = "200";
     //timer->start(30000);
}

void addRecipient::on_pushButton_6_clicked(){
     number = "600";
     //timer->start(30000);
}
