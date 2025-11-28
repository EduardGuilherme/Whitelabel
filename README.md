# Whitelabel 

Este projeto implementa um sistema **Whitelabel Multi-Tenant**, onde
cada cliente acessando o sistema possui **tema próprio**, **banco
vinculado**, **produtos**, e **usuários associados**.

## 📌 Tecnologias Utilizadas

### Backend

-   NestJS
-   Prisma ORM
-   PostgreSQL
-   JWT
-   Multi-tenant por domínio

### Frontend (Flutter)

-   Tema dinâmico
-   Login
-   Lista de produtos
-   Criação de usuário

## ⚙️ Arquitetura

    /backend
    /frontend

## 🗄️ Banco -- Modelo Prisma

``` prisma
model Client {
  id        Int      @id @default(autoincrement())
  name      String
  url       String   @unique
  domain    String?  @unique
  primaryColor String?
  users     User[]
}

model User {
  id        Int      @id @default(autoincrement())
  name      String
  email     String   @unique
  password  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  clientId  Int?
  client    Client?   @relation(fields: [clientId], references: [id])
}
```

## 🔗 Endpoints

### POST /users

``` json
{
  "name": "nome",
  "email": "email@example.com",
  "password": "Senha",
  "clientId": 1
}
```

## ▶️ Rodar Backend

``` bash
npm install
npx prisma generate
npm run start:dev
```

## 📱 Rodar Flutter

``` bash
flutter pub get
flutter run -d chrome --o Frontend foi renderizano no navegador chrome
```

## 🎨 Whitelabel

O tema é carregado conforme o domínio:

``` dart
ThemeData theme = AppThemes.getThemeForDomain(auth.currentDomain);
```

## 🧾 Sucesso ao criar usuário

``` dart
SnackBar(content: Text("Usuário criado com sucesso!"));
```
