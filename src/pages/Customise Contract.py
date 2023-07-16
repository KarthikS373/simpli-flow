import streamlit as st

from streamlit_ace import st_ace

st.title("Customise your Smart Contract")
st.write('''
            Not Happy with the generated code?  Customise your code here.
        ''')


# Spawn a new Ace editor
content = st_ace(language='python', theme='monokai', height='88vh')


# uploaded_file = st.file_uploader("Choose a file")
# if uploaded_file is not None:
#     # To read file as bytes:
#     bytes_data = uploaded_file.getvalue()
#     st.write(bytes_data)

col1, col2 = st.columns(2)

with col1:
    button1 = st.button('Audit')

with col2:
    button2 = st.button('Deploy')


if button1:
    #deploy audit function call kardo yaha se
    print("Beginning Contract Audit ...")

if button2:
    #deploy call kardo yaha se
    print("Deploying Contract ")