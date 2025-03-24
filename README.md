# MintComics.io

A modern platform for comic book tokenization and trading.

## Overview

MintComics.io is a decentralized platform that enables comic book collectors and enthusiasts to tokenize, trade, and manage their physical comic book collections using blockchain technology.

## Architecture

The platform consists of the following components:

1. **Next.js Frontend**: Modern web application for user interaction (Port 3000)
2. **User-Facing Backend**: FastAPI service for user operations with Privy.io integration (Port 8000)
3. **Internal Tokenization Portal**: 
   - Frontend: React application for admin operations (Port 3001)
   - Backend: Node.js/TypeScript service for tokenization and admin operations (Port 4001)
4. **Local Blockchain**: Hardhat blockchain for development/testing (Port 8545)

## Documentation

- [Service Startup Guide](docs/service_startup_guide.md)
- [Implementation Plan](docs/implementation_plan.md)
- [Frontend Migration](docs/frontend_migration.md)
- [API Documentation](docs/api_documentation.md)
- [Blockchain Integration](docs/blockchain_integration.md)

## Getting Started

1. Clone the repository
2. Follow the [Service Startup Guide](docs/service_startup_guide.md)
3. Set up your development environment
4. Start contributing!