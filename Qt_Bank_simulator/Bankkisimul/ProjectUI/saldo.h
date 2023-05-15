#ifndef SALDO_H
#define SALDO_H
#include "dllrestapi.h"
#include <QDialog>
#include "engine.h"
#include "menu.h"

namespace Ui {
class Saldo;
}

class Saldo : public QDialog
{
    Q_OBJECT

public:
    explicit Saldo(QWidget *parent = nullptr);
    ~Saldo();
    void getcardid(QString);

private:
    Ui::Saldo *ui;
    engine *enkine;
    DLLRestApi *manager;
    QTimer *timer = new QTimer(this);
    Menu *idsender;
    QString cardid;

public slots:
     void getSaldo(QString);
     void getCustomer(QString);
     void getActions(QString);

private slots:

     void on_pushButton_clicked();
};

#endif // SALDO_H
