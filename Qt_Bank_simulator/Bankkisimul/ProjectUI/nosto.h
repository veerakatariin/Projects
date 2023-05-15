#ifndef NOSTO_H
#define NOSTO_H

#include <QDialog>
#include <QTimer>
#include "dllrestapi.h"

namespace Ui {
class Nosto;
}

class Nosto : public QDialog
{
    Q_OBJECT

public:
    explicit Nosto(QWidget *parent = nullptr);
    ~Nosto();
    void getcardid(QString);

private slots:
    void on_pushButton_clicked();

    void on_pushButton_20_clicked();

    void on_pushButton_100_clicked();

    void on_pushButton_40_clicked();

    void on_pushButton_200_clicked();

    void on_pushButton_60_clicked();

    void on_pushButton_600_clicked();

    void on_pushButton_nosto_clicked();

private:
    Ui::Nosto *ui;
    QTimer *timer = new QTimer(this);
    DLLRestApi *manager;
    QString savesaldo;
    QString amount;
    QString cardid;

public slots:
    void getSaldo(QString);
    void getCustomer(QString);
    void getWithdrawal();

signals:



};

#endif // NOSTO_H
