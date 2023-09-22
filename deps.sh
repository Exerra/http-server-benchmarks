bold=$(tput bold)
normal=$(tput sgr0)

cd servers

cd bun-with-elysia
bun install

cd ../bun-with-serve
bun install

cd ../bun-with-hono
bun install

cd ../node-native
bun install

cd ../node-with-express
bun install

cd ../../
echo "200" >.benchmark_deps_installed

echo "\n\n${bold}✨ All dependencies installed${normal}\n\n"
