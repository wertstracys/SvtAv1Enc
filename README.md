### Dockerfile
---
```
FROM encodev/svtav1enc:2025-03-03
WORKDIR /bot
COPY .env .
CMD ["bash", "run.sh"]
```
