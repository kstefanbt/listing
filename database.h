#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME   "ListHost"
#define DATABASE_NAME       "dalist.db"

#define TABLE                   "list"
#define TABLE_ID                "id"
#define TABLE_NAME              "name"
#define TABLE_LEFT              "left"

#define TABLEE                  "element"
#define TABLEE_ID               "id"
#define TABLEE_NAME             "name"
#define TABLEE_CHECKED          "checked"
#define TABLEE_PID              "list_id"

class DataBase : public QObject
{
    Q_OBJECT
public:
    explicit DataBase(QObject *parent = 0);
    ~DataBase();
    void connectToDataBase();

private:
    QSqlDatabase    db;

private:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();

public slots:
    bool insertIntoTable1(const QVariantList &data);
    bool insertIntoTable1(const QString &id, const QString &name, const QString &left);
    bool insertIntoTable2(const QVariantList &data);
    bool insertIntoTable2(const QString &id, const QString &name, const QString &checked, const QString  &list_id);
    bool removeRecord1(const int id);
    bool removeRecord2(const int id);
    bool updateTable3(const int id);
    bool updateTable2(const int id);
    bool updateTable2a(const int id);
    bool updateTable2b(const int id);
    bool updateTable2c(const int id);
    bool updateTable2d(const int id, const int idd);
    bool updateTableNameE(QString s, const int idd);

};

#endif // DATABASE_H
