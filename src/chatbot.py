import requests
from deployment.contract_deployment  import deployment
def get_chatbot_response(user_input):
    # TODO: Chat Logic
    response = requests.post("0.0.0.0:5000/model/parse", data={"text": user_input.lower()})
    response = response.json()
    