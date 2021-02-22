#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent)
{

}

DataBase::~DataBase()
{

}

void DataBase::connectToDataBase()
{
    this->openDataBase();

}

bool DataBase::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    QDir dire = QDir::currentPath();
    dire.cdUp();
    QString path = dire.absolutePath() + "/listingP/dalist.db";
    qDebug() << path;
    //QFileInfo file("/");
    db.setHostName(DATABASE_HOSTNAME);

    db.setDatabaseName(path);
    if(db.open()){
        return true;
    } else {
        return false;
    }
}

void DataBase::closeDataBase()
{
    db.close();
}

bool DataBase::insertIntoTable1(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " TABLE " ( " TABLE_ID ", "
                                             TABLE_NAME ", "
                                             TABLE_LEFT " ) "
                  "VALUES (:id, :name, :left)");
    query.bindValue(":id",       data[0].toString());
    query.bindValue(":name",       data[1].toString());
    query.bindValue(":left",         data[2].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::insertIntoTable1(const QString &id, const QString &name, const QString &left)
{
    QVariantList data;
    data.append(id);
    data.append(name);
    data.append(left);

    if(insertIntoTable1(data))
        return true;
    else
        return false;
}

bool DataBase::removeRecord1(const int id)
{
    QSqlQuery query;

    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::insertIntoTable2(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " TABLEE " ( " TABLEE_ID ", "
                                             TABLEE_NAME ", "
                                             TABLEE_CHECKED ", "
                                             TABLEE_PID " ) "
                  "VALUES (:id, :name, :checked, :list_id)");
    query.bindValue(":id",       data[0].toString());
    query.bindValue(":name",       data[1].toString());
    query.bindValue(":checked",         data[2].toString());
    query.bindValue(":list_id",         data[3].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << TABLEE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::insertIntoTable2(const QString &id, const QString &name, const QString &checked, const QString &list_id)
{
    QVariantList data;
    data.append(id);
    data.append(name);
    data.append(checked);
    data.append(list_id);

    if(insertIntoTable2(data))
        return true;
    else
        return false;
}

bool DataBase::removeRecord2(const int id)
{
    QSqlQuery query;

    query.prepare("DELETE FROM " TABLEE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLEE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::updateTable3(const int id)
{
    QSqlQuery query;
qDebug() << id;
    query.prepare("UPDATE show SET br=:br WHERE id = 1 ");
    query.bindValue(":br", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLEE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}
bool DataBase::updateTable2(const int id)
{
    QSqlQuery query;

    query.prepare("UPDATE element SET checked = 1 WHERE id =:br");
    query.bindValue(":br", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLEE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}
bool DataBase::updateTable2a(const int id)
{
    QSqlQuery query;

    query.prepare("UPDATE element SET checked = 0 WHERE id =:br");
    query.bindValue(":br", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLEE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

