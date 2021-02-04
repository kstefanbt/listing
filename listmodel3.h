#ifndef LISTMODEL3_H
#define LISTMODEL3_H

#include <QObject>
#include <QSqlQueryModel>

class ListModel3 : public QSqlQueryModel
{
    Q_OBJECT
public:

    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        LeftRole
    };

    explicit ListModel3(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LISTMODEL3_H
