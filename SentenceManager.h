#ifndef SENTENCEMANAGER_H
#define SENTENCEMANAGER_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QList>

class SentenceManager : public QObject
{
    Q_OBJECT
public:
    SentenceManager(QDir participantDir, bool isEnglish, QObject *parent = 0);
    ~SentenceManager();
    Q_INVOKABLE QString randomSentence();

private:
    QFile usedSentencesFile;
    QList<QString> sentences;
    QList<QString> availableCodes;
    QList<QString> usedSentences;
};

#endif // SENTENCEMANAGER_H
