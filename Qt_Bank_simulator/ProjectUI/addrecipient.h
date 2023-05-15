#ifndef ADDRECIPIENT_H
#define ADDRECIPIENT_H

#include <QDialog>
#include "dllrestapi.h"

namespace Ui {
class addRecipient;
}

class addRecipient : public QDialog
{
    Q_OBJECT

public:
    explicit addRecipient(QWidget *parent = nullptr);
    ~addRecipient();
     void getRecipient(QString);
     void getcardid(QString);

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_3_clicked();

    void on_pushButton_4_clicked();

    void on_pushButton_5_clicked();

    void on_pushButton_6_clicked();

    void on_pushButton_siirr_clicked();

    void on_pushButton_sulje_clicked();


private:
    Ui::addRecipient *ui;
    DLLRestApi *manager;
    QTimer *timer = new QTimer(this);

    QString number;
    QString savesaldo;
    QString sendNumber;
    QString recipient;
    QString cardid;

public slots:
    void getSaldo(QString);
    void getWithdrawal();
    void getActions();
};

#endif // ADDRECIPIENT_H
