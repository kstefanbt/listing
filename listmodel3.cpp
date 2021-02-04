#include "listmodel3.h"
#include "database.h"

ListModel3::ListModel3(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}


QVariant ListModel3::data(const QModelIndex & index, int role) const {

    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> ListModel3::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[LeftRole] = "left";
    return roles;
}


void ListModel3::updateModel()
{
    this->setQuery("SELECT id, " TABLE_NAME ", " TABLE_LEFT " FROM " TABLE " WHERE " TABLE_LEFT "= 0");
}

int ListModel3::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
