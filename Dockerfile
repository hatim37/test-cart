## telechargement de maeven afin de construire la solution
#FROM maven:3.9.7-eclipse-temurin-17 AS build
## créer un dossier
#WORKDIR /app
##je copie le projet
#COPY pom.xml .
##
#RUN mvn -U -q -DskipTests dependency:go-offline
##
#COPY src ./src
##
#RUN mvn -U clean package -DskipTests
#
## Run
#FROM eclipse-temurin:17-jre-jammy
##
#WORKDIR /app
##
#COPY --from=build /app/target/*.jar app.jar
##
#EXPOSE 8080
## commande qui sera executé lors du lancement du container
#ENTRYPOINT ["java","-jar","app.jar"]


# --- Étape 1 : Build avec Maven ---
FROM maven:3.9.7-eclipse-temurin-17 AS build
WORKDIR /app

# Copier pom.xml et télécharger les dépendances pour accélérer le build
COPY pom.xml .
RUN mvn -U -q -DskipTests dependency:go-offline

# Copier le code source
COPY src ./src

# Compiler et packager l'application
RUN mvn -U clean package -DskipTests

# --- Étape 2 : Image finale ---
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copier le jar compilé depuis l'étape précédente
COPY --from=build /app/target/*.jar app.jar

# Cloud Run fournit $PORT automatiquement → on le mappe à Spring Boot
ENV PORT=8080
ENV JAVA_OPTS="-Xms256m -Xmx512m -Djava.awt.headless=false"

# Exposer le port pour Cloud Run
EXPOSE 8080

# Commande de lancement
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]

