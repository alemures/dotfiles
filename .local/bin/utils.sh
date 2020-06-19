#!/bin/bash

get_xres() {
    xrdb -query | grep $1: | awk '{print $2}'
}
