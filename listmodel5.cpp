#include "listmodel5.h"
#include "database.h"

ListModel5::ListModel5(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}


QVariant ListModel5::data(const QModelIndex & index, int role) const {
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> ListModel5::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CheckedRole] = "checked";
    roles[ListRole] = "listid";
    return roles;
}

void ListModel5::updateModel()
{
    this->setQuery("SELECT id, name FROM element WHERE list_id IN (SELECT br FROM show WHERE id = 1)");
}




int ListModel5::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
