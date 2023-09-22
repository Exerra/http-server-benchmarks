import { Hono } from "hono";
const app = new Hono();
const port = process.env.PORT;

app.get("/", (c) => c.text("Hello World!"));

export default {
    fetch: app.fetch,
    port: port,
};
