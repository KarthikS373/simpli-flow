def get_chatbot_response(user_input):
    # TODO: Chat Logic
    if user_input.lower() == "hello":
        return "Hi there!"
    elif user_input.lower() == "how are you?":
        return "I'm a chatbot, so I don't have feelings, but thanks for asking!"
    else:
        return "I'm sorry, I didn't quite catch that. Can you please rephrase?"