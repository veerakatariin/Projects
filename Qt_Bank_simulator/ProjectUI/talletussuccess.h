#ifndef TALLETUSSUCCESS_H
#define TALLETUSSUCCESS_H

#include <QDialog>
#include "dllrestapi.h"

namespace Ui {
class talletusSuccess;
}

class talletusSuccess : public QDialog
{
    Q_OBJECT

public:
    explicit talletusSuccess(QWidget *parent = nullptr);
    ~talletusSuccess();
    void getcardid(QString);


private:
    Ui::talletusSuccess *ui;
    DLLRestApi *manager;
    QString cardid;
     QTimer *timer = new QTimer;

public slots:
    void saldoFromInterface(QString);

private slots:
    void on_pushButton_clicked();
};

#endif // TALLETUSSUCCESS_H
