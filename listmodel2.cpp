#include "listmodel2.h"
#include "database.h"

ListModel2::ListModel2(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}


QVariant ListModel2::data(const QModelIndex & index, int role) const {

    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> ListModel2::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CheckedRole] = "checked";
    roles[ListRole] = "listid";
    return roles;
}


void ListModel2::updateModel()
{
    this->setQuery("SELECT id, name FROM element WHERE checked = 0 AND list_id IN (SELECT br FROM show WHERE id = 1)");
}

int ListModel2::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
