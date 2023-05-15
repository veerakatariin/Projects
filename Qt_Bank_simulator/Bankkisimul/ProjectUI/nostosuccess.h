#ifndef NOSTOSUCCESS_H
#define NOSTOSUCCESS_H

#include <QDialog>
#include "dllrestapi.h"

namespace Ui {
class nostosuccess;
}

class nostosuccess : public QDialog
{
    Q_OBJECT

public:
    explicit nostosuccess(QWidget *parent = nullptr);
    ~nostosuccess();
    void getcardid(QString);

private:
    Ui::nostosuccess *ui;
    DLLRestApi *manager;
    QString cardid;

public slots:
    void getSaldo(QString);

private slots:
    void on_pushButton_clicked();
};

#endif // NOSTOSUCCESS_H
