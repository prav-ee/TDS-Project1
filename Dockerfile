FROM python:3.10-slim

ARG APP_PORT=7860
ENV PORT=${APP_PORT}

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    cmake \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN useradd -m -u 1000 user
USER user

ENV HOME=/home/user
ENV PATH="${HOME}/.local/bin:${PATH}"

WORKDIR /app

COPY --chown=user requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=user . .
COPY --chown=user . .

EXPOSE ${APP_PORT}

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]