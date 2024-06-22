# Baojs Rest API - Bun

Create a new bun project

```shell
bun init -y 
```

Package.json

```json
{
  "name": "baojs-rest-api",
  "module": "index.js",
  "scripts": {
    "start": "bun run index.js",
    "dev": "bun run --hot --watch index.js"
  },
  "devDependencies": {
    "bun-types": "^0.5.0",
    "prisma": "^4.15.0"
  },
  "dependencies": {
    "amqplib": "^0.10.3",
    "baojs": "^0.2.1",
    "cors": "^2.8.5",
    "dotenv": "^16.1.3",
    "mongoose": "^7.2.2",
    "redis": "^4.6.10",
    "redis-om": "^0.4.2",
    "uuid": "^9.0.1"
  }
}
```

index.js 

```js
const { Bao }  = require("baojs");
const { getApiInfo, getPosts, createPosts, getSinglePost } = require("./controllers.js");

const app = new Bao();

app.get("/", getApiInfo);
app.get("/posts", getPosts);
app.post("/posts", createPosts);
app.get("/posts/:id", getSinglePost);
app.notFoundHandler((ctx) => {
  return ctx.sendPrettyJson({ message: "Resource not found!" });
});

const server = app.listen({ port: 5000 });

console.log(`Listening on ${server.hostname}:${server.port}`);
```

db.js 

```js
const { config } = require("dotenv");
const { connect } = require("mongoose");

config();

const MONGO_URI = process.env.MONGO_URI || "mongodb://localhost/baojs-rest-api";

async function dbConnection() {
  try {
    const conn = await connect(MONGO_URI, { maxPoolSize: 5 });
    console.log(`Database connection initiated: ${conn.connections[0].host}`);
    return conn;
  } catch (error) {
    console.log("Database Connection Error: ", error.message);
    throw new Error("Database connection failed!");
  }
}

module.exports = dbConnection;
```

models.js

```js
const { Schema, model } = require("mongoose");

const PostSchema = new Schema({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  published: {
    type: Boolean,
    required: false,
    default: false
  }
});

const Post = model('Post', PostSchema);

module.exports = Post;
```

controllers.js

```js
const dbConnection = require("./db.js");
const Post = require("./models.js");

exports.getApiInfo = (ctx) => {
  return ctx.sendPrettyJson({ apiVersion: "1.0.0" });
};

exports.getPosts = async (ctx) => {
  try {
    await dbConnection();
    const posts = await Post.find();
    return ctx.sendPrettyJson(posts);
  } catch (err) {
    console.log("Error: ", err);
    return ctx.sendPrettyJson({ error: { message: "Error fetching posts" }});
  }
};

exports.createPosts = async (ctx) => {
  try {
    await dbConnection();
    const { title, description } = await ctx.req.json();
    console.log({title, description});
    const newPost = new Post({
      title,
      description
    });
    newPost.save();
    return ctx.sendPrettyJson({message: `Post created!`, post_id: newPost._id});
  } catch (err) {
    console.log("Error: ", err);
    return ctx.sendPrettyJson({error: { message: "Error creating posts"}});
  }
};

exports.getSinglePost = async (ctx) => {
  try {
    await dbConnection();
    const id = await ctx.params.id;
    const post = await Post.findById({_id: id});
    return ctx.sendPrettyJson(post);
  } catch (err) {
    console.log({error: err});
    return ctx.sendPrettyJson({ error: { message: "Error fetching post"}})
  }
};
```
