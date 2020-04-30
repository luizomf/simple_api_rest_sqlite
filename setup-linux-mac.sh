#!/bin/sh
cp .env_example .env
npm i
npx sequelize db:migrate
npx sequelize db:seed:all
npm run dev