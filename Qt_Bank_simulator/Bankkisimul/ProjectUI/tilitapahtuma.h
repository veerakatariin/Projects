#ifndef TILITAPAHTUMA_H
#define TILITAPAHTUMA_H

#include <QDialog>
#include "dllrestapi.h"

namespace Ui {
class Tilitapahtuma;
}

class Tilitapahtuma : public QDialog
{
    Q_OBJECT

public:
    explicit Tilitapahtuma(QWidget *parent = nullptr);
    ~Tilitapahtuma();
    void getcardid(QString);

private slots:
    void on_pushButton_tilitakaisin_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_clicked();

private:
    Ui::Tilitapahtuma *ui;
    DLLRestApi *manager;
    QTimer *timer = new QTimer(this);
    QString cardid;
    QString id;
    QString actionid;

public slots:
    void getCustomer(QString);
    void getActions(QString);
    void getSaldo(QString);
};

#endif // TILITAPAHTUMA_H
