import random
import pandas as pd
import streamlit as st

st.title("Your Contracts")

st.write('''
            The list of contract instances that you have deployed with SimpliFlow on the Flow Blockchain.
        ''')


import pandas as pd
import random
import string

import pandas as pd
import random
import string

def generate_random_address():
    return '0x' + ''.join(random.choice(string.hexdigits[:-6]) for _ in range(40))

def generate_random_contract_name():
    adjectives = ["Secure", "Decentralized", "Smart", "Efficient", "Trustless", "Transparent"]
    nouns = ["Token", "Exchange", "Wallet", "Protocol", "Oracle", "DAO"]
    return f"{random.choice(adjectives)} {random.choice(nouns)}"

def generate_dataframe(num_contracts):
    data = {
        "Contract Name": [generate_random_contract_name() for _ in range(num_contracts)],
        "Contract Address": [generate_random_address() for _ in range(num_contracts)],
        "Status": [random.choice(['Deployed', 'Awaiting Audit', 'Audited', 'In Development']) for _ in range(num_contracts)],
        "Creation Date": [f"2023-07-{random.randint(1, 31)}" for _ in range(num_contracts)],
        "Version": [f"v{random.randint(1, 10)}.{random.randint(0, 5)}.{random.randint(0, 20)}" for _ in range(num_contracts)],
    }
    return pd.DataFrame(data)

# Usage example:
num_contracts = 5  # Change this number to generate more or fewer contracts
df = generate_dataframe(num_contracts)





st.dataframe(
    df,
    column_config={
        "Name": "Contract Name",
        "Address": st.column_config.LinkColumn(
            "Contract Address",
            help="Address of the contract",
        ),
        "url": st.column_config.LinkColumn("App URL"),
        "views_history": st.column_config.LineChartColumn(
            "Views (past 30 days)", y_min=0, y_max=5000
        ),
    },
    hide_index=True,
    use_container_width=True,

)


uploaded_file = st.file_uploader("Upload Smart Contract")
if uploaded_file is not None:
    # To read file as bytes:
    bytes_data = uploaded_file.getvalue()
    st.write(bytes_data)