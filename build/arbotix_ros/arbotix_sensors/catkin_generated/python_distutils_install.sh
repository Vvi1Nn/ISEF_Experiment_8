#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/zwh/experiment_5/src/arbotix_ros/arbotix_sensors"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/zwh/experiment_5/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/zwh/experiment_5/install/lib/python3/dist-packages:/home/zwh/experiment_5/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/zwh/experiment_5/build" \
    "/usr/bin/python3" \
    "/home/zwh/experiment_5/src/arbotix_ros/arbotix_sensors/setup.py" \
     \
    build --build-base "/home/zwh/experiment_5/build/arbotix_ros/arbotix_sensors" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/zwh/experiment_5/install" --install-scripts="/home/zwh/experiment_5/install/bin"
