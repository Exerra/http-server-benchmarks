GREEN="\033[1;32m"
RED="\033[0;31m"
NC='\033[0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

depsInstalled=false

FILE=.benchmark_deps_installed
if test -f "$FILE"; then
	depsInstalled=true
fi

if [ "$depsInstalled" = false ]; then
	echo "${BOLD}${RED}⚠️ Dependencies not installed. Running ./deps.sh.${NC}${NORMAL}"
	./deps.sh
fi

# ----------------------------------------------------------------------

echo "${GREEN}Bun with Elysia${NC}\n"

PORT=3000 bun run servers/bun-with-elysia/src/index.ts >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/bun-with-elysia.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"

echo "${GREEN}Bun with Serve${NC}\n"

PORT=3000 bun run servers/bun-with-serve/index.ts >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/bun-with-serve.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"

echo "${GREEN}Bun with node HTTP${NC}\n"

PORT=3000 bun run servers/node-native/index.js >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/bun-with-node-http.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"

echo "${GREEN}Bun with Express${NC}\n"

PORT=3000 bun run servers/node-with-express/index.js >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/bun-with-express.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"
echo "${GREEN}Bun with Hono${NC}\n"

PORT=3000 bun --bun run servers/bun-with-hono/index.js >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/bun-with-hono.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"

echo "${GREEN}Node with http${NC}\n"

PORT=3000 node servers/node-native/index.js >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/node-native.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"

echo "${GREEN}Node with Express${NC}\n"

PORT=3000 node servers/node-with-express/index.js >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/node-with-express.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"
echo "${GREEN}Node with Hono${NC}\n"

PORT=3000 node servers/node-with-hono/index.js >/dev/null 2>&1 &
serverPID=$!

sleep 2 # waits for the server to start

bombardier http://localhost:3000 --format=pt --print=r | tee results/node-with-hono.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n--------------------------------------\n\n"

echo "${GREEN}Rust with actix${NC}\n"

echo "\nBuilding the server...\n"

cargo build --release --manifest-path servers/rust/Cargo.toml >/dev/null 2>&1 &
compilePID=$!

wait $compilePID 2>/dev/null
unset compilePID

./servers/rust/target/release/rust >/dev/null 2>&1 &
serverPID=$!

sleep 2

bombardier http://localhost:3000 --format=pt --print=r | tee results/rust.txt

kill $serverPID
wait $serverPID 2>/dev/null
unset serverPID

# ----------------------------------------------------------------------

echo "\n\n${BOLD}🥳 All of the benchmarks were saved in the results folder.${NORMAL}"
