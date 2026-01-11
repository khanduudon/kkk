# ✅ Stable Python (avoid python:latest)
FROM python:3.12-slim

# ✅ Recommended env
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# ✅ Workdir
WORKDIR /app

# ✅ System deps:
# - gcc/build-essential: tgcrypto (C extension) compile
# - git/curl: some packages might need it
# (You can remove git/curl if not needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ✅ Upgrade pip/setuptools/wheel first (helps pyproject builds)
RUN pip install --upgrade pip setuptools wheel

# ✅ Install python deps first (better layer caching)
COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

# ✅ If you really need this extra step (optional)
RUN pip install "pymongo[srv]" || true

# ✅ Copy app code
COPY . /app

# ✅ Start
CMD ["python", "main.py"]
