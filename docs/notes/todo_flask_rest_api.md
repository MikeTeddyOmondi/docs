# Todo Flask Rest API

app.py

```python
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_restful import Resource, Api, reqparse, abort
from flask_cors import CORS
# from dataclasses import dataclass
from dotenv import load_dotenv
import os

load_dotenv()

DEBUG = os.getenv("DEBUG")
DB_URI = os.getenv("DB_URI")

app = Flask(__name__)

cors = CORS(app)

api = Api(app)

app.config['SQLALCHEMY_DATABASE_URI'] = DB_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

migrate = Migrate(app, db)

# @dataclass
class Todo(db.Model):
    __tablename__ = 'todo'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=False)
    completed = db.Column(db.Boolean(120), default=False, nullable=False)

    def __repr__(self):
        return 'Task %r' % self.id

    def serialize(self):
        return { "id": self.id, "title": self.title, "completed": self.completed}

TODOS = {}

parser = reqparse.RequestParser()
parser.add_argument('task', required=True, help="Task cannot be blank!")


# Todo
# shows a single todo item and lets you delete a todo item
class TodoSingle(Resource):
    def get(self, todo_id):
        todo = db.get_or_404(Todo, todo_id)
        return jsonify(todo)

    def delete(self, todo_id):
        abort_if_todo_doesnt_exist(todo_id)
        del TODOS[todo_id]
        return '', 204

    def put(self, todo_id):
        args = parser.parse_args()
        task = {'task': args['task']}
        TODOS[todo_id] = task
        return task, 201


# TodoList
# shows a list of all todos, and lets you POST to add new tasks
class TodoList(Resource):
    def get(self):
        all_todos = Todo.query.all()
        print(all_todos.serialize())
        return jsonify(all_todos.serialize())

    def post(self):
        args = parser.parse_args()
        # print(args)
        new_title = args["task"]
        new_todo = Todo(
            title=new_title
        )
        print(new_todo)
        db.session.add(new_todo)
        db.session.commit()
        return new_todo, 201

##
## Actually setup the Api resource routing here
##
api.add_resource(TodoList, '/todos')
api.add_resource(TodoSingle, '/todos/<todo_id>')

##
## Run the App
##
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=DEBUG)

```



.env

```
DEBUG=True
DB_URI=mysql://root:password@127.0.0.1:3306/todo-flask-api
```



requirements.txt

```
alembic==1.9.2
aniso8601==9.0.1
click==8.1.3
Flask==2.2.2
Flask-Cors==3.0.10
Flask-Migrate==4.0.1
Flask-MySQLdb==1.0.1
Flask-RESTful==0.3.9
Flask-SQLAlchemy==3.0.2
greenlet==2.0.1
importlib-metadata==6.0.0
importlib-resources==5.10.2
itsdangerous==2.1.2
Jinja2==3.1.2
Mako==1.2.4
MarkupSafe==2.1.1
mysqlclient==2.1.1
python-dotenv==0.21.0
pytz==2022.7
six==1.16.0
SQLAlchemy==1.4.46
Werkzeug==2.2.2
zipp==3.11.0
```



## Migrations - Using Alembic

initialize alembic in the project diretory

```shell
alembic init alembic
```

For starting up with just a single database and the generic configuration, setting up the SQLAlchemy URL is all that’s needed:

```ini
# ...some other config

sqlalchemy.url = postgresql://scott:tiger@localhost/test

# ...the rest of the config 
```

#### Create a migration script:

With the environment in place we can create a new revision, using `alembic revision`:

```shell
alembic revision -m "REVISION NAME"
```

#### Run the migrations

```shell
alembic upgrade head
```

#### Get Info on migrations state

```shell
alembic current
```

#### Downgrade migrations to beginning

```shell

```
