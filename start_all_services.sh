#!/bin/bash
# MintComics.io service startup script
# This script follows the recommended startup procedure from service_startup_guide.md

echo "Starting MintComics.io services in separate terminal windows..."

# Check if PostgreSQL container for internal portal is running and start if needed
echo "Checking PostgreSQL container status for internal portal..."
if ! docker ps | grep -q mintcomics-postgres; then
  echo "Starting PostgreSQL container for internal portal..."
  docker run --name mintcomics-postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_DB=mintcomics_internal \
    -p 5434:5432 \
    -d postgres:14
  echo "PostgreSQL container started for internal portal (port 5434)"
  sleep 5
else
  echo "PostgreSQL container for internal portal already running"
fi

# Check if PostgreSQL container for user-facing backend is running and start if needed
echo "Checking PostgreSQL container status for user-facing backend..."
if ! docker ps | grep -q mintcomics-user-postgres; then
  echo "Starting PostgreSQL container for user-facing backend..."
  docker run --name mintcomics-user-postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_DB=mintcomics_user \
    -p 5433:5432 \
    -d postgres:14
  echo "PostgreSQL container started for user-facing backend (port 5433)"
  sleep 5
else
  echo "PostgreSQL container for user-facing backend already running"
fi

# Start Hardhat blockchain
osascript -e 'tell app "Terminal" to do script "cd '$PWD'/blockchain && npx hardhat node"'
echo "Started Hardhat blockchain node (port 8545)"
sleep 5

# Start user-facing backend API
osascript -e 'tell app "Terminal" to do script "cd '$PWD'/user-backend && source venv/bin/activate && export DB_TYPE=postgres && uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"'
echo "Started user-facing backend API (port 8000)"
sleep 3

# Start internal portal backend
osascript -e 'tell app "Terminal" to do script "cd '$PWD'/internal-portal/backend && npm start"'
echo "Started internal portal backend (port 4001)"
sleep 3

# Start Next.js frontend
osascript -e 'tell app "Terminal" to do script "cd '$PWD'/new-frontend && npm run dev"'
echo "Started Next.js frontend (port 3000)"
sleep 3

# Start internal portal frontend (explicitly setting port to 3001)
osascript -e 'tell app "Terminal" to do script "cd '$PWD'/internal-portal/frontend && PORT=3001 npm start"'
echo "Started internal portal frontend (port 3001)"

echo "==========================================================="
echo "MintComics.io development environment is now running!"
echo "==========================================================="
echo "Next.js Frontend: http://localhost:3000"
echo "User-Facing Backend API: http://localhost:8000"
echo "User-Facing API Docs: http://localhost:8000/docs"
echo "Internal Portal Frontend: http://localhost:3001"
echo "Internal Portal API: http://localhost:4001"
echo "PostgreSQL Database (Internal): localhost:5434"
echo "PostgreSQL Database (User-Facing): localhost:5433"
echo "Hardhat Network: http://localhost:8545"
echo "==========================================================="
echo "To stop all services, close the terminal windows or use:"
echo "pkill -f \"node.*3000\" && pkill -f \"node.*3001\" && pkill -f \"uvicorn\" && pkill -f \"ts-node\" && pkill -f \"hardhat\""
echo "To stop PostgreSQL containers:"
echo "docker stop mintcomics-postgres mintcomics-user-postgres"
echo "===========================================================" 