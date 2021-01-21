#!/bin/bash
LOG='/var/log/workspace-image.log'

env | grep GITPOD | tee -a $LOG