TEMPLATE = app

# Executable Name
TARGET = TankAssignment
CONFIG += debug c++17

# Force .exe extension on Windows
win32 {
    TARGET = TankAssignment.exe
}

# Destination
DESTDIR = ./
OBJECTS_DIR = ./build/

# Headers
HEADERS += ../common/Shader.h \
           ../common/Vector.h \
           ../common/Matrix.h \
           ../common/Mesh.h \
           ../common/Texture.h \
           ../common/SphericalCameraManipulator.h \
           ../common/map.h \
           ../common/drawObj.h \
           ../common/DrawPlayer.h \
           ../common/DrawEnemy.h \
           ../common/drawBullet.h \
           ../common/Coins.h \
           Game.h \



# Sources
SOURCES += main.cpp \
           Game.cpp \
           ../common/Shader.cpp \
           ../common/Vector.cpp \
           ../common/Matrix.cpp \
           ../common/Mesh.cpp \
           ../common/Texture.cpp \
           ../common/SphericalCameraManipulator.cpp

# Include Paths
INCLUDEPATH += ./ \
               ../common/
        
win32: LIBS += -lglew32 -lfreeglut -lopengl32
unix: LIBS += -lGLEW -lGL -lGLU -lglut