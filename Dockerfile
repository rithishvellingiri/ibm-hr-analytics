# Stage 1: Build stage
FROM python:3.10-slim AS builder

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir pandas numpy matplotlib seaborn scikit-learn streamlit joblib

# Stage 2: Final stage (lightweight)
FROM python:3.10-slim

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]