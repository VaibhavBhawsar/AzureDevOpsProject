# Use official Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy files
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Expose port and start app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
