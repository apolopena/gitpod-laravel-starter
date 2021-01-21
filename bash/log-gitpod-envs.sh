#!/bin/bash
LOG='/var/log/workspace-image.log'

#env | tee -a $LOG
pwd | tee -a '/var/log/workspace-image.log'