/****************************************************************************
** Meta object code from reading C++ file 'videoplayer.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.1.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../29_video_player/videoplayer.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'videoplayer.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.1.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_VideoPlayer_t {
    const uint offsetsAndSize[24];
    char stringdata0[116];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_VideoPlayer_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_VideoPlayer_t qt_meta_stringdata_VideoPlayer = {
    {
QT_MOC_LITERAL(0, 11), // "VideoPlayer"
QT_MOC_LITERAL(12, 12), // "stateChanged"
QT_MOC_LITERAL(25, 0), // ""
QT_MOC_LITERAL(26, 12), // "VideoPlayer*"
QT_MOC_LITERAL(39, 6), // "player"
QT_MOC_LITERAL(46, 12), // "initFinished"
QT_MOC_LITERAL(59, 10), // "playFailed"
QT_MOC_LITERAL(70, 12), // "frameDecoded"
QT_MOC_LITERAL(83, 8), // "uint8_t*"
QT_MOC_LITERAL(92, 4), // "data"
QT_MOC_LITERAL(97, 13), // "VideoSwsSpec&"
QT_MOC_LITERAL(111, 4) // "spec"

    },
    "VideoPlayer\0stateChanged\0\0VideoPlayer*\0"
    "player\0initFinished\0playFailed\0"
    "frameDecoded\0uint8_t*\0data\0VideoSwsSpec&\0"
    "spec"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_VideoPlayer[] = {

 // content:
       9,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   38,    2, 0x06,    0 /* Public */,
       5,    1,   41,    2, 0x06,    2 /* Public */,
       6,    1,   44,    2, 0x06,    4 /* Public */,
       7,    3,   47,    2, 0x06,    6 /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 3, 0x80000000 | 8, 0x80000000 | 10,    4,    9,   11,

       0        // eod
};

void VideoPlayer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<VideoPlayer *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->stateChanged((*reinterpret_cast< VideoPlayer*(*)>(_a[1]))); break;
        case 1: _t->initFinished((*reinterpret_cast< VideoPlayer*(*)>(_a[1]))); break;
        case 2: _t->playFailed((*reinterpret_cast< VideoPlayer*(*)>(_a[1]))); break;
        case 3: _t->frameDecoded((*reinterpret_cast< VideoPlayer*(*)>(_a[1])),(*reinterpret_cast< uint8_t*(*)>(_a[2])),(*reinterpret_cast< VideoSwsSpec(*)>(_a[3]))); break;
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
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< VideoPlayer* >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (VideoPlayer::*)(VideoPlayer * );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&VideoPlayer::stateChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (VideoPlayer::*)(VideoPlayer * );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&VideoPlayer::initFinished)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (VideoPlayer::*)(VideoPlayer * );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&VideoPlayer::playFailed)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (VideoPlayer::*)(VideoPlayer * , uint8_t * , VideoSwsSpec & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&VideoPlayer::frameDecoded)) {
                *result = 3;
                return;
            }
        }
    }
}

const QMetaObject VideoPlayer::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_VideoPlayer.offsetsAndSize,
    qt_meta_data_VideoPlayer,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_VideoPlayer_t
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<VideoPlayer *, std::false_type>, QtPrivate::TypeAndForceComplete<uint8_t *, std::false_type>, QtPrivate::TypeAndForceComplete<VideoSwsSpec &, std::false_type>



>,
    nullptr
} };


const QMetaObject *VideoPlayer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *VideoPlayer::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_VideoPlayer.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int VideoPlayer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void VideoPlayer::stateChanged(VideoPlayer * _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void VideoPlayer::initFinished(VideoPlayer * _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void VideoPlayer::playFailed(VideoPlayer * _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void VideoPlayer::frameDecoded(VideoPlayer * _t1, uint8_t * _t2, VideoSwsSpec & _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
