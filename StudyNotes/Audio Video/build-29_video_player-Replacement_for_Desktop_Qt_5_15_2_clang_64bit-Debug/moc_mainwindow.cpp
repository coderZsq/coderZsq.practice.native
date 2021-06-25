/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.1.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../29_video_player/mainwindow.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.1.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MainWindow_t {
    const uint offsetsAndSize[26];
    char stringdata0[219];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_MainWindow_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_MainWindow_t qt_meta_stringdata_MainWindow = {
    {
QT_MOC_LITERAL(0, 10), // "MainWindow"
QT_MOC_LITERAL(11, 20), // "onPlayerStateChanged"
QT_MOC_LITERAL(32, 0), // ""
QT_MOC_LITERAL(33, 12), // "VideoPlayer*"
QT_MOC_LITERAL(46, 6), // "player"
QT_MOC_LITERAL(53, 20), // "onPlayerInitFinished"
QT_MOC_LITERAL(74, 18), // "onPlayerPlayFailed"
QT_MOC_LITERAL(93, 18), // "on_stopBtn_clicked"
QT_MOC_LITERAL(112, 22), // "on_openFileBtn_clicked"
QT_MOC_LITERAL(135, 29), // "on_currentSlider_valueChanged"
QT_MOC_LITERAL(165, 5), // "value"
QT_MOC_LITERAL(171, 28), // "on_volumnSlider_valueChanged"
QT_MOC_LITERAL(200, 18) // "on_playBtn_clicked"

    },
    "MainWindow\0onPlayerStateChanged\0\0"
    "VideoPlayer*\0player\0onPlayerInitFinished\0"
    "onPlayerPlayFailed\0on_stopBtn_clicked\0"
    "on_openFileBtn_clicked\0"
    "on_currentSlider_valueChanged\0value\0"
    "on_volumnSlider_valueChanged\0"
    "on_playBtn_clicked"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MainWindow[] = {

 // content:
       9,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   62,    2, 0x08,    0 /* Private */,
       5,    1,   65,    2, 0x08,    2 /* Private */,
       6,    1,   68,    2, 0x08,    4 /* Private */,
       7,    0,   71,    2, 0x08,    6 /* Private */,
       8,    0,   72,    2, 0x08,    7 /* Private */,
       9,    1,   73,    2, 0x08,    8 /* Private */,
      11,    1,   76,    2, 0x08,   10 /* Private */,
      12,    0,   79,    2, 0x08,   12 /* Private */,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   10,
    QMetaType::Void, QMetaType::Int,   10,
    QMetaType::Void,

       0        // eod
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MainWindow *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->onPlayerStateChanged((*reinterpret_cast< VideoPlayer*(*)>(_a[1]))); break;
        case 1: _t->onPlayerInitFinished((*reinterpret_cast< VideoPlayer*(*)>(_a[1]))); break;
        case 2: _t->onPlayerPlayFailed((*reinterpret_cast< VideoPlayer*(*)>(_a[1]))); break;
        case 3: _t->on_stopBtn_clicked(); break;
        case 4: _t->on_openFileBtn_clicked(); break;
        case 5: _t->on_currentSlider_valueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->on_volumnSlider_valueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: _t->on_playBtn_clicked(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 0:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< VideoPlayer* >(); break;
            }
            break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< VideoPlayer* >(); break;
            }
            break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< VideoPlayer* >(); break;
            }
            break;
        }
    }
}

const QMetaObject MainWindow::staticMetaObject = { {
    QMetaObject::SuperData::link<QMainWindow::staticMetaObject>(),
    qt_meta_stringdata_MainWindow.offsetsAndSize,
    qt_meta_data_MainWindow,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_MainWindow_t

, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>


>,
    nullptr
} };


const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow.stringdata0))
        return static_cast<void*>(this);
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
