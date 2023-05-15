#include "menu.h"
#include "ui_menu.h"
#include "tilitapahtuma.h"
#include "nosto.h"
#include "saldo.h"
#include "talletus.h"
#include "siirto.h"
#include "mainwindow.h"
#include <QTimer>

//painaessa menu ikkunan painikkeita menu sulkeutuu ja uusi ikkuna avautuu
//kun jokin ikkuna suljetaan, avautuu menu uudelleen
//jos menussa ei tehdä mitään 30 sekuntiin, palataan aloituskäyttöliittymään
//kirjaudu ulos painikkeella päästään takaisin aloituskäyttöliittymään

Menu::Menu(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Menu){
    ui->setupUi(this);

    manager = new DLLRestApi;
    connect(manager, SIGNAL(nameToExe(QString)),
           this, SLOT(getCustomer(QString)));
    manager->getCustomer(cardid);

    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_ulos_clicked()));
    //timer->start(30000);

    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode
}

Menu::~Menu()
{
    delete ui;
    delete timer;
    timer = nullptr;
    delete manager;
    manager = nullptr;
}

//laitetaan näytölle tilin omistajan nimi
void Menu::getCustomer(QString customer){
    ui->lineEdit->setText(customer);
}

//tuodaan kortinid menuun ja asetetaan se muuttujaan
void Menu::getid(QString id){
    cardid = id;
}

//näppäimet tapahtuman valintaan
void Menu::on_pushButton_tili_clicked()
{
    this->close();
    Tilitapahtuma tilit;
    tilit.setModal(true);
    tilit.exec();
    //timer->start(30000);

}

void Menu::on_pushButton_nosto_clicked()
{
    this->close();
    Nosto nosto;
    nosto.setModal(true);
    nosto.exec();
   // timer->start(30000);

}

void Menu::on_pushButton_saldo_clicked()
{
    this->close();
    Saldo saldo;
    saldo.setModal(true);
    saldo.exec();
    //timer->start(30000);

}

void Menu::on_pushButton_siirto_clicked()
{
    this->close();
    Siirto siirto;
    siirto.setModal(true);
    siirto.exec();
    //timer->start(30000);
}


void Menu::on_pushButton_talletus_clicked()
{
    this->close();
    Talletus talletus;
    talletus.setModal(true);
    talletus.exec();
    //timer->start(30000);

}


void Menu::on_pushButton_ulos_clicked()
{
    this->close();
    MainWindow *w = new MainWindow;
    w->show();

}


