import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_iris

# Charger un dataset simple
data = load_iris()
X_train, X_test, y_train, y_test = train_test_split(data.data, data.target, test_size=0.2)

# Démarrer une nouvelle expérience
with mlflow.start_run():
    # Créer un modèle
    model = RandomForestClassifier()
    model.fit(X_train, y_train)
    
    # Enregistrer le modèle
    mlflow.sklearn.log_model(model, "model")
    
    # Calculer la précision et l'enregistrer
    accuracy = model.score(X_test, y_test)
    mlflow.log_metric("accuracy", accuracy)
