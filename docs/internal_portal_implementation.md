# Internal Portal Implementation Guide

## Overview
The Internal Portal is a critical component of MintComics.io, providing administrators with tools for comic tokenization, quality control, and batch processing. This document details the implementation and architecture of the internal portal.

## Architecture

### Frontend (Port 3001)
The internal portal frontend is a React application that provides the administrative interface for comic tokenization and management.

#### Key Features
1. **Authentication**
   - Admin-only access
   - Role-based permissions
   - Session management

2. **Comic Management**
   - Batch upload interface
   - Metadata editor
   - Quality control dashboard
   - Preview functionality

3. **Tokenization Controls**
   - Smart contract deployment
   - NFT minting interface
   - Batch processing tools
   - Transaction monitoring

4. **Analytics**
   - Processing statistics
   - Error reporting
   - Performance metrics
   - Activity logs

### Backend (Port 4001)
The backend service is built with FastAPI and handles all administrative operations and blockchain interactions.

#### Core Components
1. **API Layer**
   - RESTful endpoints
   - WebSocket connections
   - Authentication middleware
   - Rate limiting

2. **Database Layer**
   - PostgreSQL integration
   - Asset metadata storage
   - Processing queue management
   - Audit logging

3. **Blockchain Service**
   - Smart contract interaction
   - Transaction management
   - Gas optimization
   - Error handling

4. **Processing Pipeline**
   - Image optimization
   - Metadata validation
   - IPFS integration
   - Quality checks

## Implementation Details

### Frontend Implementation

```typescript
// Component Structure
internal-portal/
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Dashboard/
│   │   │   ├── TokenizationForm/
│   │   │   ├── BatchProcessor/
│   │   │   └── QualityControl/
│   │   ├── services/
│   │   │   ├── api.ts
│   │   │   ├── blockchain.ts
│   │   │   └── websocket.ts
│   │   └── utils/
│   │       ├── validation.ts
│   │       └── formatting.ts
│   └── package.json
```

### Backend Implementation

```python
# API Structure
internal-portal/
├── backend/
│   ├── app/
│   │   ├── api/
│   │   │   ├── routes/
│   │   │   ├── models/
│   │   │   └── services/
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   └── security.py
│   │   └── main.py
│   └── requirements.txt
```

## Configuration

### Environment Variables
```bash
# Frontend (.env)
REACT_APP_API_URL=http://localhost:4001
REACT_APP_WS_URL=ws://localhost:4001/ws
PORT=3001

# Backend (.env)
DATABASE_URL=postgresql://user:pass@localhost:5434/mintcomics_internal
JWT_SECRET=your-secret-key
BLOCKCHAIN_RPC=http://localhost:8545
```

### Database Schema
```sql
-- Core Tables
CREATE TABLE comics (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE processing_queue (
    id SERIAL PRIMARY KEY,
    comic_id INTEGER REFERENCES comics(id),
    status VARCHAR(50) NOT NULL,
    priority INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    comic_id INTEGER REFERENCES comics(id),
    tx_hash VARCHAR(66),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);
```

## Security Considerations

1. **Authentication**
   - JWT-based authentication
   - Role-based access control
   - Session timeout
   - CORS configuration

2. **API Security**
   - Rate limiting
   - Input validation
   - SQL injection prevention
   - XSS protection

3. **Blockchain Security**
   - Private key management
   - Transaction signing
   - Gas limits
   - Error handling

4. **Data Protection**
   - Encryption at rest
   - Secure communication
   - Audit logging
   - Backup procedures

## Error Handling

1. **Frontend Errors**
```typescript
try {
  await api.processComic(comicData);
} catch (error) {
  if (error.response?.status === 429) {
    notifyRateLimit();
  } else {
    logError(error);
    notifyGenericError();
  }
}
```

2. **Backend Errors**
```python
@app.exception_handler(ValidationError)
async def validation_exception_handler(request: Request, exc: ValidationError):
    return JSONResponse(
        status_code=400,
        content={"detail": exc.errors()}
    )
```

## Performance Optimization

1. **Frontend**
   - Code splitting
   - Lazy loading
   - Caching strategies
   - WebSocket optimization

2. **Backend**
   - Database indexing
   - Query optimization
   - Connection pooling
   - Async processing

3. **Blockchain**
   - Batch transactions
   - Gas optimization
   - Nonce management
   - Event listening

## Monitoring

1. **System Health**
   - Service uptime
   - Response times
   - Error rates
   - Resource usage

2. **Processing Metrics**
   - Queue length
   - Processing time
   - Success rate
   - Error distribution

3. **Blockchain Stats**
   - Transaction success
   - Gas usage
   - Contract calls
   - Event emissions

## Deployment

1. **Prerequisites**
   - Node.js 16+
   - Python 3.9+
   - PostgreSQL 14+
   - Docker

2. **Installation**
```bash
# Frontend
cd internal-portal/frontend
npm install
PORT=3001 npm start

# Backend
cd internal-portal/backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --host 0.0.0.0 --port 4001
```

3. **Docker Deployment**
```yaml
version: '3.8'
services:
  frontend:
    build: ./frontend
    ports:
      - "3001:3001"
    environment:
      - PORT=3001
      
  backend:
    build: ./backend
    ports:
      - "4001:4001"
    depends_on:
      - db
      
  db:
    image: postgres:14
    ports:
      - "5434:5432"
```

## Troubleshooting

1. **Common Issues**
   - Port conflicts
   - Database connectivity
   - WebSocket timeouts
   - Transaction failures

2. **Debug Tools**
   - Network inspector
   - Database profiler
   - Blockchain explorer
   - Log aggregator

3. **Resolution Steps**
   - Check service status
   - Verify configurations
   - Review error logs
   - Test connectivity