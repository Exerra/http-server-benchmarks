const http = require("http");
const port = process.env.PORT

const requestListener = function (req, res) {
    res.writeHead(200);
    res.end("Hello world!");
};

const server = http.createServer(requestListener);
server.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});