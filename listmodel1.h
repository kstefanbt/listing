#ifndef LISTMODEL1_H
#define LISTMODEL1_H

#include <QObject>
#include <QSqlQueryModel>

class ListModel1 : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        LeftRole
    };

    explicit ListModel1(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LISTMODEL1_H
