#include "nostosuccess.h"
#include "ui_nostosuccess.h"
#include "menu.h"

nostosuccess::nostosuccess(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::nostosuccess)
{
    ui->setupUi(this);

    manager = new DLLRestApi;
    manager->getSaldo(cardid);

    connect(manager, SIGNAL(saldoToExe(QString)),
           this, SLOT(getSaldo(QString)));

    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode

}

nostosuccess::~nostosuccess()
{
    delete ui;
    delete manager;
    manager = nullptr;
}

//tuodaan kortin id menusta
void nostosuccess::getcardid(QString id){
    cardid = id;
}

//haetaan tietokannasta päivittynyt saldo
void nostosuccess::getSaldo(QString saldo){
    ui->lineEdit->setText(saldo);
}

//sulje nappi josta pääsee takaisin menuun
void nostosuccess::on_pushButton_clicked()
{
    this->close();
    Menu kir;
    kir.setModal(true);
    kir.exec();
}
