#ifndef NOSTOFAIL_H
#define NOSTOFAIL_H

#include <QDialog>
#include <QTimer>

namespace Ui {
class nostofail;
}

class nostofail : public QDialog
{
    Q_OBJECT

public:
    explicit nostofail(QWidget *parent = nullptr);
    ~nostofail();

private slots:
    void on_pushButton_clicked();

private:
    Ui::nostofail *ui;
    QTimer *timer = new QTimer(this);
};

#endif // NOSTOFAIL_H
