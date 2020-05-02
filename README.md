# Uma API REST simples para consumo de dados

Atenção: você precisa ter o NodeJS instalado no seu computador.  

Para subir o projeto no ar com SQLite, copie o arquivo `.env_example` para `.env`.  

Você também precisará adicionar uma secret key no arquivo `.env`:

```
TOKEN_SECRET='sua_secret_key_aqui'
```

Execute os comandos abaixo:

```
npm i
npx sequelize db:migrate
npx sequelize db:seed:all
npm run dev
```

Neste ponto sua API deverá está rodando no endereço http://127.0.0.1:3001/.

Caso queira migrar para MySQL/MariaDB, edite as configurações de base de dados no arquivo `.env`, configure também o `src/config/database.js`.

Para SQLite as configurações são:

```javascript
require('dotenv').config();

module.exports = {
  dialect: 'sqlite',
  storage: './db.sqlite',
  define: {
    timestamps: true,
    underscored: true,
    underscoredAll: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
  },
};
```

Para MySQL/MariaDB as configurações são:

```javascript
require('dotenv').config();

module.exports = {
  host: process.env.DATABASE_HOST,
  port: process.env.DATABASE_PORT,
  username: process.env.DATABASE_USERNAME,
  password: process.env.DATABASE_PASSWORD,
  database: process.env.DATABASE,
  dialectOptions: {
    timezone: 'America/Sao_Paulo',
  },
  timezone: 'America/Sao_Paulo',

  define: {
    timestamps: true,
    underscored: true,
    underscoredAll: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
  },
};
```

Perceba que as configurações começando com `process.env.` vem do arquivo `.env`.

Os dados de usuário e senha dos arquivos de seed são:

- email = admin@email.com
- senha = 123456

Você pode obter o token JWT na rota `/tokens`, passando os dados JSON:

```json
{
	"email": "admin@email.com",
	"password": "123456"
}
```

Headers:

```
Content-Type	application/json; charset=utf-8
```
# endpoints

Os seguintes endpoints estão configurados:

## Home - não há nada aqui

- `/` - GET

## Usuários (users)

- `/users` - DELETE - Apaga o usuário logado
- `/users` - PUT - Atualiza o usuário logado
- `/users` - POST - Cria um usuário
- `/users/:id` - GET - Mostra o usuário do ID enviado (rota desativada)
- `/users` - GET - Mostra todos os usuários (rota desativada)

**Dados para usuários (JSON)**

```
{
	"nome": "nome válido",
	"password": "senha válida",
	"email": "email_valido@email.com"
}
```

## Tokens

- `/tokens` - POST - Obtém o token JWT

**Dados para tokens (JSON)**

```
{
	"email": "admin@email.com",
	"password": "123456"
}
```

## Aluno

- `/alunos/:id` - DELETE - Apaga o aluno do ID enviado
- `/alunos/:id` - PUT - Atualiza o aluno do ID enviado
- `/alunos` - POST - Cria um aluno
- `/alunos/:id` - GET - Mostra o aluno do ID enviado
- `/alunos` - GET - Mostra todos os alunos


**Dados para tokens (JSON)**

```
{
	"nome": "Nome",
	"sobrenome": "Sobrenome",
	"email": "email@email.com",
	"idade": "50",
	"peso": "80.04",
	"altura": "1.90"
}
```

## Fotos

Atenção aqui, esse é o único endpoint `multipart/form-data` para envio de arquivos.

- `/fotos` - POST - Recebe um arquivo de foto JPG ou PNG e um `aluno_id`.

**Dados para fotos (multipart/form-data)**

```
{
	"foto": (ARQUIVO.PNG|JPG),
	"aluno_id": ":id"
}
```