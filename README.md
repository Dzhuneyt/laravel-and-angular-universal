# Docker-Compose stack: Laravel, Angular Universal, MySQL, Redis

![Logo](https://i.imgur.com/aJcN0HB.png)

Docker Compose based, Laravel + Angular template for quickly starting new projects that use Laravel for the backend (REST APIs) and Angular (plus server side rendering) for the frontend.

### Starting the stack

    docker-compose up
    
### Executing DB migrations

    docker-compose exec backend php artisan migrate
