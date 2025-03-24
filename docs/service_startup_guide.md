# MintComics.io Service Startup Guide

## Service Overview

MintComics.io consists of the following services:

1. **Next.js Frontend**: Modern web application for user interaction (Port 3000)
2. **User-Facing Backend**: FastAPI service for user operations with Privy.io integration (Port 8000)
3. **Internal Tokenization Portal**: 
   - Frontend: React application for admin operations (Port 3001)
   - Backend: Node.js/TypeScript service for tokenization and admin operations (Port 4001)
4. **Local Blockchain**: Hardhat blockchain for development/testing (Port 8545)

## Using the Start All Script

For convenience, you can use the provided `start_all_services.sh` script to launch all services:

```bash
chmod +x start_all_services.sh
./start_all_services.sh
```

This script will:
1. Start necessary PostgreSQL containers
2. Launch the local blockchain
3. Start the user-facing backend
4. Launch the Next.js frontend and internal portal

## Verifying Service Health

### Local Blockchain
- Ensure the Hardhat node is running on port 8545
- Verify contracts are deployed with `cat blockchain/contract-addresses.json`

### Internal Tokenization Portal
- Access the frontend at http://localhost:3001
- Verify backend API access with `curl http://localhost:4001/api/tokenize/status`

### User-Facing Backend
- Access the health check endpoint: http://localhost:8000/health
- Verify API documentation at http://localhost:8000/docs

### Next.js Frontend
- Access the application at http://localhost:3000
- Check browser console for connection errors

## Common Issues and Troubleshooting

### Port Conflicts
- **Issue**: "Address already in use" errors when starting services
- **Solution**: 
  - Check for running processes with `lsof -i :<port>` (e.g., `lsof -i :3001`)
  - Kill conflicting processes with `kill -9 <PID>`
  - Ensure you're not running duplicate services

### Wrong Service on Port 3001
- **Issue**: The internal portal UI should be on port 3001
- **Solution**:
  - Always start the internal portal frontend with `PORT=3001 npm start`
  - Never start the Next.js frontend on port 3001

### Database Connectivity
- **Issue**: Cannot connect to databases
- **Solution**: Check that PostgreSQL containers are running and available on the expected ports

### Internal Portal Communication
- **Issue**: User backend can't communicate with internal portal
- **Solution**: Verify INTERNAL_PORTAL_BASE_URL is set to http://localhost:4001/api