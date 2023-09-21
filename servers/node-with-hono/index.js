import { Hono } from "hono";
import { serve } from "@hono/node-server";
const app = new Hono();
const port = process.env.PORT;

app.get("/", (c) => c.text("Hello World!"));

serve({
    fetch: app.fetch,
    port: port,
});
