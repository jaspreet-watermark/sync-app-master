# Todo APP

# Overview
This is master Application which automatically Sync data to slave Application https://github.com/jaspreet-watermark/sync-app-slave 

# Installation
````
git clone https://github.com/jaspreet-watermark/todo.git
cd todo
bundle install
rake db:create
rails s
````

### Run Background Workers
In new terminal

````
bundle exec sidekiq -q daemons -q default
````

## Run Specs
````
rspec
````

## API Docs
````
http://localhost:3000/swagger
````