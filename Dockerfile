FROM python:latest
RUN pip install --upgrade pip
COPY requirements.txt requirements.txt
WORKDIR .
COPY . .
RUN pip3 install -r requirements.txt
RUN python -m pip install "pymongo[srv]"
CMD ["python3", "main.py"]