FROM python:3.12-slim

RUN pip install --upgrade pip

COPY requirements.txt requirements.txt
WORKDIR .
COPY . .

RUN pip install -r requirements.txt
RUN pip install "pymongo[srv]"

CMD ["python", "main.py"]
