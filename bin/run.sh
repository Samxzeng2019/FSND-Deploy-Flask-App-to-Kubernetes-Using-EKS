#!/bin/bash
echo 'init virtual environment'
. ~/workspace/venv/containerapp/Scripts/activate

echo "install dependencies"
cd ~/workspace/FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS
pip install -r requirements.txt

echo "start app"
cd ~/workspace/FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS
export JWT_SECRET='myjwtsecret'
export LOG_LEVEL=DEBUG
python main.py

