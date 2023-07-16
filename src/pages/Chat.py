import sys
sys.path.append('..')

from time import time
from random import randint

import streamlit as st
from streamlit_chat import message

from chatbot import get_chatbot_response

st.set_page_config(page_title="Flow Hackathon", layout="centered")

st.title("Simpli Flow")

if "messages" not in st.session_state:
    st.session_state["messages"] = [{"role": "assistant", "content": "How can I help you?"}]

with st.form("chat_input", clear_on_submit=True):
    a, b = st.columns([4, 1])
    user_input = a.text_input(
        label="Your message:",
        placeholder="What would you like to say?",
        label_visibility="collapsed",
    )
    b.form_submit_button("Send", use_container_width=True)

for msg in st.session_state.messages:
    message(msg["content"], is_user=msg["role"] == "user")

if user_input:
    key = f"chat_widget_{int(time())}_{randint(0, 100)}"
    st.session_state.messages.append({"role": "user", "content": user_input})
    message(user_input, is_user=True, key=key)
    if 'previous' not in st.session_state:
        st.session_state['previous'] = None
    bot_response, st.session_state['previous'] = get_chatbot_response(user_input, st.session_state['previous'])
    st.session_state.messages.append({"role": "assistant", "content": bot_response})
    key = f"chat_widget_{int(time())}_{randint(0, 100)}"
    message(bot_response, key=key)