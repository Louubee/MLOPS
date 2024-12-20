# Projet MLOps avec CI/CD sur AWS

Ce projet met en place une chaîne complète MLOps en intégrant des pratiques DevOps, en utilisant des outils spécifiques au Machine Learning, et en suivant une approche Infrastructure as Code (IaC) et CI/CD.

## Technologies utilisées
- **Conteneurisation** : Docker
- **Infrastructure as Code (IaC)** : Terraform
- **Configuration** : Ansible
- **Cloud** : AWS
- **ML Tracking** : MLflow
- **CI/CD** : GitHub Actions
- **Monitoring** : Prometheus + Grafana

## Étapes réalisées

1. **Création de l'infrastructure avec Terraform** :  
   L'infrastructure a été définie et déployée à l'aide de Terraform, permettant de créer et gérer automatiquement des ressources dans AWS. Une instance EC2 a été provisionnée dans la région **Europe (Paris)**, avec une configuration adaptée au *Free Tier* d'AWS. Ce processus a permis d'automatiser le déploiement et la configuration de l'infrastructure, y compris le choix d'une **AMI** compatible, et la configuration des groupes de sécurité pour autoriser les connexions SSH.

2. **Configuration de l'instance EC2** :  
   Une fois l'instance EC2 lancée, la clé SSH a été utilisée pour accéder à la machine distante. Le groupe de sécurité AWS a été configuré pour permettre l'accès sur le port **22** depuis l'adresse IP publique de l'utilisateur. Cette étape garantit la connectivité sécurisée avec l'instance EC2 et permet la gestion de l'environnement à distance.

3. **Installation de MLflow et préparation de l'environnement** :  
   Après la connexion à l'instance EC2, MLflow a été installé pour gérer et suivre les expérimentations de Machine Learning. Les dépendances nécessaires à l'exécution des modèles ML (comme `scikit-learn`, `tensorflow`, etc.) ont été installées, et un script Python `train.py` a été téléchargé. Ce script contient le code pour entraîner un modèle de Machine Learning et est exécuté sur l'instance pour tester l'intégration du flux de travail.

4. **Suivi des expérimentations avec MLflow** :  
   Le serveur MLflow a été lancé sur l'instance EC2, accessible via le port **5000** à l'adresse **`http://<PUBLIC_IP>:5000`**. MLflow a été configuré pour enregistrer et visualiser les paramètres, les métriques, et les artefacts des expérimentations de modèles. Cette étape permet de suivre facilement l'évolution des modèles, la comparaison des résultats et l'optimisation des hyperparamètres.

5. **Mise en place de CI/CD avec GitHub Actions** :  
   L'automatisation des tests et des déploiements a été mise en place avec **GitHub Actions**. Un workflow CI/CD a été configuré pour automatiser les étapes suivantes :  
   - Lorsqu'un push est effectué sur le dépôt GitHub, une action est déclenchée pour tester le code, construire l'environnement Docker et lancer les tests unitaires.
   - En cas de succès, le workflow déploie le modèle et les scripts d'entraînement dans l'instance EC2 via SSH.
   Ce processus assure une intégration continue et un déploiement rapide à chaque mise à jour du code, réduisant ainsi le temps entre le développement et la mise en production.

6. **Surveillance et Monitoring avec Prometheus et Grafana** :  
   Un système de **monitoring** a été mis en place pour suivre les performances de l'infrastructure et des modèles. **Prometheus** a été configuré pour collecter des métriques concernant l'utilisation des ressources de l'instance EC2, tandis que **Grafana** a été utilisé pour créer des dashboards interactifs permettant de visualiser ces métriques en temps réel. Cela permet de suivre la santé de l'environnement de production, de détecter les anomalies et d'optimiser les performances des modèles ML déployés.

## Conclusion
Ce projet a permis de construire une chaîne complète d'intégration et de déploiement pour des modèles Machine Learning, tout en automatisant le processus de gestion des ressources, de l'entraînement à la mise en production. Grâce à l'utilisation de Terraform, Ansible, MLflow, GitHub Actions, et des outils de monitoring comme Prometheus et Grafana, nous avons établi un flux de travail robuste, automatisé et scalable qui répond aux besoins des équipes DevOps et MLOps. Ce projet facilite le suivi des expérimentations, le déploiement continu et l'observabilité des performances des modèles sur AWS.
