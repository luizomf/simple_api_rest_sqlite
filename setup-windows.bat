copy .env_example .env
call npm i
call npx sequelize db:migrate
call npx sequelize db:seed:all
call npm run dev
