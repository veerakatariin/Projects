#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "dllrestapi.h"
#include "menu.h"
#include "newdllserialport.h"
#include "engine.h"
#include "dllpincode.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:

    void on_pushButton_loggin_clicked();

private:
    Ui::MainWindow *ui;
    DLLRestApi *manager;
    NewDLLSerialPort *Pinterface;
    DLLPinCode *pPincode;
    Menu *idsender;
    QTimer *timer = new QTimer(this);

    QString cardid;
    QString pincode;
    int tryToLogin;

public slots:
     void calldllserialport();
     void getCode(QString);

};
#endif // MAINWINDOW_H
