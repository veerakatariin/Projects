#include "talletussuccess.h"
#include "ui_talletussuccess.h"
#include "menu.h"

talletusSuccess::talletusSuccess(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::talletusSuccess)
{
    ui->setupUi(this);
    manager = new DLLRestApi;
    manager->getSaldo(cardid);

    connect(manager, SIGNAL(saldoToExe(QString)),
            this, SLOT(saldoFromInterface(QString)));
    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_clicked()));
    //timer->start(10000);
}

talletusSuccess::~talletusSuccess()
{
    delete ui;
    delete manager;
    manager = nullptr;
    delete timer;
    timer = nullptr;
}

//tuodaan menusta kortin idnumero
void talletusSuccess::getcardid(QString id){
    cardid = id;
}

//näytetään päivittynyt saldo näytöllä
void talletusSuccess::saldoFromInterface(QString saldo){
    ui->lineEdit->setText(saldo);
}

//sulje painike jolla päästään takaisin menuun
void talletusSuccess::on_pushButton_clicked()
{
    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
}
