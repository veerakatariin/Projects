#include "pincodeengine.h"
#include "ui_pincodeengine.h"

pincodeEngine::pincodeEngine(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::pincodeEngine)
{
    ui->setupUi(this);
    qDebug()<<"Luodaan PinDLL engine";

    this->setWindowState(Qt::WindowMaximized);
    this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);
}

pincodeEngine::~pincodeEngine()
{
    qDebug()<<"Tuhotaan DLL:n pinEnginessä";
    delete ui;
}


QString pincodeEngine::returnValueToInterface()
{
    return pincode;
}

void pincodeEngine::on_B1_clicked(){

    pin += ui->B1->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B2_clicked(){

    pin += ui->B2->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B3_clicked(){

    pin += ui->B3->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B4_clicked(){

    pin += ui->B4->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B5_clicked(){

    pin += ui->B5->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B6_clicked(){

    pin += ui->B6->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B7_clicked(){

    pin += ui->B7->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B8_clicked(){

    pin += ui->B8->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B9_clicked(){

    pin += ui->B9->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_B0_clicked(){

    pin += ui->B0->text();
    ui->lineEdit->setText(ui->lineEdit->text()+"*");

}
void pincodeEngine::on_Cancel_clicked(){

    pin.chop(1);
    choppedText = ui->lineEdit->text();
    choppedText.chop(1);
    ui->lineEdit->setText(choppedText);

}


void pincodeEngine::on_OK_clicked()
{
    pincode = pin;
    pin = "";
    ui->lineEdit->setText("");
    this->close();
}
