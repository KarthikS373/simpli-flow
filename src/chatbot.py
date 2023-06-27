import re
from deployment.contract_deployment  import deployment
def get_chatbot_response(user_input):
    # TODO: Chat Logic
    if user_input.lower() == "hello":
        return "Hi there!"
    elif user_input.lower() == "how are you?":
        return "I'm a chatbot, so I don't have feelings, but thanks for asking!"
    elif user_input.lower() == "I want to deploy a cadence contract":
        return "tell your address"
    # elif re.findall("^0x",user_input) != "":
    #     return deployment("4edbd4bc470a8479","b25bd802d71b47a4c86aec8d620eea8ee4cdd12b4b94abee068aca24afb2f332")
    else:
        return "I'm sorry, I didn't quite catch that. Can you please rephrase?"