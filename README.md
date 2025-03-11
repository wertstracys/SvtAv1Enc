### Dockerfile
---
```
FROM encodev/svtav1enc:2025-03-11
WORKDIR /bot
COPY .env .
CMD ["bash", "run.sh"]
```
