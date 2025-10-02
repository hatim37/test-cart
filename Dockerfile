# telechargement de maeven afin de construire la solution
FROM maven:3.9.7-eclipse-temurin-17 AS build
# créer un dossier
WORKDIR /app
#je copie le projet
COPY pom.xml .
#
RUN mvn -U -q -DskipTests dependency:go-offline
#
COPY src ./src
#
RUN mvn -U clean package -DskipTests

# Run
FROM eclipse-temurin:17-jre-jammy
#
WORKDIR /app
#
COPY --from=build /app/target/*.jar app.jar
#
EXPOSE 8080
# commande qui sera executé lors du lancement du container
ENTRYPOINT ["java","-jar","app.jar"]




## ─── Build Stage ─────────────────────────────
#FROM maven:3.9.7-eclipse-temurin-17 AS build
#
#WORKDIR /app
#
## Copier pom et télécharger les dépendances
#COPY pom.xml .
#RUN mvn -U -q -DskipTests dependency:go-offline
#
## Copier le code source
#COPY src ./src
#
## Build jar
#RUN mvn -U clean package -DskipTests
#
## ─── Runtime Stage ───────────────────────────
#FROM eclipse-temurin:17-jre-jammy
#
#WORKDIR /app
#
## Copier le jar depuis l'étape build
#COPY --from=build /app/target/*.jar app.jar
#
## Port exposé pour Cloud Run
#EXPOSE 8080
#
## Headless mode pour ImageIO/ZXing
#ENV JAVA_TOOL_OPTIONS="-Djava.awt.headless=true -Xms256m -Xmx512m"
#
## Port variable par défaut pour Cloud Run
#ENV PORT=8080
#
## Commande de démarrage
#ENTRYPOINT ["sh", "-c", "java $JAVA_TOOL_OPTIONS -jar app.jar"]
#

# --------------------------
# Étape 1 : Build Maven
# --------------------------
#FROM maven:3.9.7-eclipse-temurin-17 AS build
#
#WORKDIR /app
#
## Copier pom.xml et récupérer les dépendances offline
#COPY pom.xml .
#RUN mvn -U -q -DskipTests dependency:go-offline
#
## Copier le code source et compiler
#COPY src ./src
#RUN mvn -U clean package -DskipTests
#
## --------------------------
## Étape 2 : Runtime
## --------------------------
#FROM eclipse-temurin:17-jre-jammy
#
#WORKDIR /app
#
## Copier le jar compilé
#COPY --from=build /app/target/*.jar app.jar
#
## Exposer le port
#EXPOSE 8080
#
## Headless pour ImageIO / ZXing
#ENV JAVA_OPTS="-Xms256m -Xmx512m -Djava.awt.headless=true -Dfile.encoding=UTF-8"
#ENV PORT=8080
#
## Lancer l'application
#ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
