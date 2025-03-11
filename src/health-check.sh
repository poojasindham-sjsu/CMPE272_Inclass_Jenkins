#!/bin/bash

echo "Running health check..."

# URL to check (Change this based on your actual service)
URL="http://localhost:8080/health"

# Try to get a 200 OK response within 10 seconds
for i in {1..10}; do
    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

    if [ "$STATUS_CODE" -eq 200 ]; then
        echo "Health check passed!"
        exit 0
    else
        echo "Health check failed (Attempt $i)... retrying in 5s"
        sleep 5
    fi
done

echo "Health check failed after multiple attempts."
exit 1  # Fail if we never get a 200 response
