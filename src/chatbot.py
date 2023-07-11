import requests
from deployment.contract_deployment import deployment
from generate import generate_code
from audit import CadenceContractAuditor


def get_chatbot_response(user_input, previous):
    # ? This is for follow ups
    if (previous == 'generate_contract'):
        return generate_contract(user_input), None
    if (previous == 'audit_contract'):
        return CadenceContractAuditor(user_input).generate_report(), None

    # ? This is for getting the intent from the user input
    response = requests.post(
        "http://0.0.0.0:5005/model/parse", json={"text": user_input.lower()})
    response = response.json()
    intent = response['intent']['name']
    if (intent == 'generate_contract'):
        return 'Please enter the description of the contract', 'generate_contract'
    elif (intent == 'audit_contract'):
        return 'Please enter the contract code', 'audit_contract'
    return "I didn't understand what you mean to say, please try rephrasing.", 'nlu_fallback'


def generate_contract(description):
    code = generate_code(description)
    return code


'''
greet
goodbye
affirm
deny
mood_great
mood_unhappy
bot_challenge
audit_contract
deploy_contract
generate_contract
nlu_fallback
'''
