# cap_stone_project_1
- Project 1 


# Create an Virtual environment
- mkdir myproject
- cd myproject
- py -3 -m venv .venv

# Activate the script
-  .venv\Scripts\activate

## Installing Dependencies
- pip install requests
- pip install flask
- pip install python-dotenv


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
# Service discovery 
- 


### Dockerfile
- This file builds a docker Image for this weather service app

 ``` dockerfile
 
    FROM python:3.9-slim

    WORKDIR /app

    COPY requirements.txt /app/

    RUN pip install --no-cache-dir -r requirements.txt

    COPY . /app/

    EXPOSE 5000

    CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]



```