
Create configs
```
cp config/database.example.yml config/database.yml
cp config/application.example.yml config/application.yml
```

Create db
```
rake db:create && rake db:migrate && rake db:seed
```

Create admin user
```
rake manager:admin:create
```