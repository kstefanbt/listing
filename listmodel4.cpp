#include "listmodel4.h"
#include "database.h"

ListModel4::ListModel4(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}


QVariant ListModel4::data(const QModelIndex & index, int role) const {
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> ListModel4::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CheckedRole] = "checked";
    roles[ListRole] = "listid";
    return roles;
}

void ListModel4::updateModel()
{
    this->setQuery("SELECT id, " TABLEE_NAME ", " TABLEE_CHECKED ", " TABLEE_PID " FROM " TABLEE " WHERE " TABLEE_CHECKED " = 1 ");
}

void ListModel4::updateM(int i){
    QSqlQuery query;
    QString s = QString::number(i);
    QString queryString = "SELECT id, name, checked, list_id FROM element WHERE list_id = " + s;
    query.prepare(queryString);
    this->setQuery(query);

}

int ListModel4::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
