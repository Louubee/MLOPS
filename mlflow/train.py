
import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

# Charger les données
data = load_iris()
X_train, X_test, y_train, y_test = train_test_split(data.data, data.target, test_size=0.2, random_state=42)

# Entraîner un modèle
model = RandomForestClassifier()
model.fit(X_train, y_train)

# Suivi avec MLflow
mlflow.set_experiment("mlops-example")
with mlflow.start_run():
    mlflow.sklearn.log_model(model, "model")
    accuracy = model.score(X_test, y_test)
    mlflow.log_metric("accuracy", accuracy)
