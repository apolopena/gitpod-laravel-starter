#!/bin/bash
LOG='/var/log/workspace-image.log'

env | grep THEIA_WORKSPACE_ROOT | tee -a $LOG