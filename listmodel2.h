#ifndef LISTMODEL2_H
#define LISTMODEL2_H

#include <QObject>
#include <QSqlQueryModel>

class ListModel2 : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        CheckedRole,
        ListRole
    };

    explicit ListModel2(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    void updateM(int i);
    int getId(int row);
};

#endif // LISTMODEL2_H
