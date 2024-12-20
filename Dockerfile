FROM python:3.9-slim

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    curl && \
    pip install --upgrade pip && \
    pip install scikit-learn mlflow prometheus_client

# Ajouter les scripts
WORKDIR /app
COPY mlflow/train.py /app/train.py

# Commande par défaut
CMD ["python", "train.py"]
