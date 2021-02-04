#ifndef LISTMODEL4_H
#define LISTMODEL4_H

#include <QObject>
#include <QSqlQueryModel>

class ListModel4 : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        CheckedRole,
        ListRole
    };

    explicit ListModel4(QObject *parent = 0);


    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    void updateM(int i);
    int getId(int row);
};

#endif // LISTMODEL4_H
