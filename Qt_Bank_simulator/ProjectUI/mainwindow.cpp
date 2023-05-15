#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>
#include "engine.h"
#include "newdllserialport.h"


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    manager = new DLLRestApi;
    idsender = new Menu;
    Pinterface = new NewDLLSerialPort(this);

    connect(manager, SIGNAL(cardToExe(QString)),
            this, SLOT(getCode(QString)));     //palauttaa pinkoodin

    //timer->singleShot(2000, this, SLOT(calldllserialport()));
    this->setWindowState(Qt::WindowMaximized);      // Asetetaan ikkuna koko ruudulle
    //this->setWindowFlags(Qt::CustomizeWindowHint | Qt::FramelessWindowHint);        // Asetetaan ikkunalle fullscreen -mode

}

//kutsutaan DLLSerialPortin funktioita
void MainWindow::calldllserialport()
{
    Pinterface->openAndRead();
    Pinterface->readPorts();
}

MainWindow::~MainWindow()
{
    delete ui;
    delete manager;
    manager = nullptr;
    delete Pinterface;
    Pinterface = nullptr;
    delete idsender;
    idsender = nullptr;
    delete timer;
    timer = nullptr;
}

//väliaikainen
void MainWindow::on_pushButton_loggin_clicked()
{
    cardid = "1";
    idsender->getid(cardid);
    qDebug() << "id saatu" + cardid;

    pPincode = new DLLPinCode;
    //this->close();
    pPincode->openPinWindow();
    pincode = pPincode->getPin();
    //this->show();
    qDebug() << pincode;
}

//kun oikea pinkoodi palautetaan, tarkistetaan syötetty koodi
void MainWindow::getCode(QString code){
    qDebug() << code;

    if(pincode == code) {

        this->close();
        Menu * kir = new Menu;
        kir->show();
        kir->exec();
    }

    else if((pincode!=code) && (tryToLogin>1)){
        qDebug() <<"kortti on lukittu";
        //tee kortin lukitus
    }
    else if(pincode !=code){
        QMessageBox::warning(this, "Login", "Tunnus ei ole oikein");
        tryToLogin += 1;
        code = nullptr;
        pincode = "";
        pPincode->openPinWindow();
    }
}


