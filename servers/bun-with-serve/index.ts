const server = Bun.serve({
    port: process.env.PORT,
    fetch(req) {
        return new Response("Hello World!")
    }
})

console.log("Bun with serve running on port " + server.port)